
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/providers/bs_api_client_provider.dart';
import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';
import '../../data/repository/far_asset_repository.dart';
import '../../data/service/far_asset_api_service.dart';
import '../../data/service/far_asset_export_service.dart';
import '../../domain/model/far_asset.dart';


final farAssetApiServiceProvider = Provider<FarAssetApiService>((ref) {
  return FarAssetApiService(ref.watch(bsApiClientProvider));
});

final farAssetExportServiceProvider = Provider<FarAssetExportService>((ref) {
  return FarAssetExportService(ref.watch(bsApiClientProvider));
});

final farAssetRepositoryProvider = Provider<FarAssetRepository>((ref) {
  return FarAssetRepository(ref.watch(farAssetApiServiceProvider));
});

class FarAssetListController extends StateNotifier<AsyncValue<List<FarAsset>>> {
  FarAssetListController(this._repository, this._legalEntityId)
    : super(const AsyncValue.loading()) {
    load();
  }

  final FarAssetRepository _repository;
  final int? _legalEntityId;

  String? _assetType;
  String? _status;
  String _search = '';

  int? get legalEntityId => _legalEntityId;
  String? get assetType => _assetType;
  String? get status => _status;
  String get search => _search;

  Future<void> load({String? assetType, String? status, String? search}) async {
    _assetType = assetType;
    _status = status;
    _search = search ?? '';

    if (_legalEntityId == null) {
      state = const AsyncValue.data(<FarAsset>[]);
      return;
    }

    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => _repository.getFarAssets(
        assetType: _assetType,
        status: _status,
        search: _search,
      ),
    );
  }

  Future<void> applyFilters({String? assetType, String? status}) {
    return load(assetType: assetType, status: status, search: _search);
  }

  Future<void> searchFarAssets(String value) {
    return load(assetType: _assetType, status: _status, search: value);
  }

  Future<void> clearFilters() {
    return load(assetType: null, status: null, search: '');
  }

  Future<void> refresh() {
    return load(assetType: null, status: null, search: null);
  }
}
final farAssetListControllerProvider =
    StateNotifierProvider<FarAssetListController, AsyncValue<List<FarAsset>>>((
      ref,
    ) {
      final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);
      return FarAssetListController(
        ref.watch(farAssetRepositoryProvider),
        currentLegalEntity?.id,
      );
    });