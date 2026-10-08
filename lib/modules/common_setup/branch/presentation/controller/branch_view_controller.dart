/*
===============================================================================
 BizSoft ERP - Common Setup - Branch
===============================================================================

 File Name    : branch_view_controller.dart
 Purpose      : Loads a single Branch for read-only viewing.
 Company      : BizSoft Systems

===============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';
import '../../data/repository/branch_repository.dart';
import '../../domain/model/branch.dart';
import 'branch_list_controller.dart';

class BranchViewController extends StateNotifier<AsyncValue<Branch>> {
  BranchViewController(
    this._repository,
    this._branchId,
    this._currentLegalEntityId,
  ) : super(const AsyncValue.loading()) {
    load();
  }

  final BranchRepository _repository;
  final int _branchId;
  final int? _currentLegalEntityId;

  Future<void> load() async {
    state = const AsyncValue.loading();

  //   state = await AsyncValue.guard(
  //     () => _repository.getBranchById(_branchId),
  //   );
  // }

  state = await AsyncValue.guard(
      () async {
        final branch =
            await _repository
                .getBranchById(
          _branchId,
        );

        if (_currentLegalEntityId ==
            null) {
          throw StateError(
            'No current Legal Entity is selected.',
          );
        }

        if (branch.legalEntity !=
            _currentLegalEntityId) {
          throw StateError(
            'This Branch does not belong '
            'to the current Legal Entity.',
          );
        }

        return branch;
      },
    );
  }

  Future<void> refresh() async {
    await load();
  }
}

final branchViewControllerProvider = StateNotifierProvider.autoDispose
    .family<BranchViewController, AsyncValue<Branch>, int>(
  (ref, branchId) {
    final currentLegalEntity =
        ref.watch(
      bsCurrentLegalEntityProvider,
    );

    return BranchViewController(
      ref.watch(branchRepositoryProvider),
      branchId,
      currentLegalEntity?.id,
    );
  },
);