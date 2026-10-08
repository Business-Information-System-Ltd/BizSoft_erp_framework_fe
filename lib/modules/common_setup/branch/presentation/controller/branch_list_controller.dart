/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_list_controller.dart
 Purpose      : Branch list controller.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a module controller for the Branch golden example.
 - UI pages should read this controller instead of calling repositories directly.
 - Uses Riverpod legacy StateNotifier API exposed by flutter_riverpod/legacy.dart.

===============================================================================
*/
import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';
import '../../data/service/branch_export_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/providers/bs_api_client_provider.dart';
import '../../data/repository/branch_repository.dart';
import '../../data/service/branch_api_service.dart';
import '../../domain/model/branch.dart';

final branchApiServiceProvider = Provider<BranchApiService>((ref) {
  return BranchApiService(ref.watch(bsApiClientProvider));
});

final branchExportServiceProvider = Provider<BranchExportService>((ref) {
  return BranchExportService(ref.watch(bsApiClientProvider));
});

final branchRepositoryProvider = Provider<BranchRepository>((ref) {
  return BranchRepository(ref.watch(branchApiServiceProvider));
});

class BranchListController extends StateNotifier<AsyncValue<List<Branch>>> {
  BranchListController(this._repository,this._legalEntityId,) : super(const AsyncValue.loading()) {
    load();
  }

  final BranchRepository _repository;
  final int? _legalEntityId;

  String? _branchType;
  String? _status;
  String _search = '';
  int? get legalEntityId =>
      _legalEntityId;
  String? get branchType => _branchType;
  String? get status => _status;
  String get search => _search;

  Future<void> load({
    String? branchType,
    String? status,
    String? search,
  }) async {
    _branchType = branchType;
    _status = status;
    _search = search ?? '';
    if (_legalEntityId ==
        null) {
      state =
          const AsyncValue.data(
        <Branch>[],
      );

      return;
    }


    state = const AsyncValue.loading();

    state = await AsyncValue.guard(
      () => _repository.getBranches(
        legalEntityId:
              _legalEntityId,
        branchType: _branchType,
        status: _status,
        search: _search,
      ),
    );
  }

  Future<void> applyFilters({String? branchType, String? status}) {
    return load(branchType: branchType, status: status, search: _search);
  }

  Future<void> searchBranches(String value) {
    return load(branchType: _branchType, status: _status, search: value);
  }

  Future<void> clearFilters() {
    return load(branchType: null, status: null, search: '');
  }

  Future<void> refresh() {
    return load(branchType: null, status: null, search: null);
  }
}



final branchListControllerProvider =
    StateNotifierProvider<BranchListController, AsyncValue<List<Branch>>>((
      ref,
    ) {
      final currentLegalEntity =
        ref.watch(
      bsCurrentLegalEntityProvider,
    );
      return BranchListController(ref.watch(branchRepositoryProvider),
      currentLegalEntity?.id,);
    });
