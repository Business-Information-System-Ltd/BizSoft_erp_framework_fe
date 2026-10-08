

import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';
import '../../data/repository/far_asset_repository.dart';
import '../../domain/model/far_asset.dart';
import 'far_asset_draft_list_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class FarAssetViewController extends StateNotifier<AsyncValue<FarAsset>> {
  FarAssetViewController(
    this._repository,
    this._assetId,
    this._currentLegalEntityId,
  ) : super(const AsyncValue.loading()) {
    load();
  }

  final FarAssetRepository _repository;
  final int _assetId;
  final int? _currentLegalEntityId;

  Future<void> load() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final farAsset = await _repository.getFarAssetById(_assetId);

      if (_currentLegalEntityId == null) {
        throw StateError('No current Legal Entity is selected.');
      }

      

      return farAsset;
    });
  }

  Future<void> refresh() async {
    await load();
  }
}

final farAssetViewControllerProvider = StateNotifierProvider.autoDispose
    .family<FarAssetViewController, AsyncValue<FarAsset>, int>((ref, assetId) {
      final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);

      return FarAssetViewController(
        ref.watch(farAssetRepositoryProvider),
        assetId,
        currentLegalEntity?.id,
      );
    });
