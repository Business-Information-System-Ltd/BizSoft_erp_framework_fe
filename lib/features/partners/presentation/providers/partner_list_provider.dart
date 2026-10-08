/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_list_provider.dart
 Purpose      : *   Manages Partner browse/search/filter list state.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/partner_repository.dart';
import '../../domain/enums/partner_enums.dart';
import '../../domain/models/partner_model.dart';
import 'partner_providers.dart';

class PartnerListState {
  const PartnerListState({
    this.items = const <PartnerModel>[],
    this.loading = false,
    this.error,
    this.search = '',
    this.partnerType,
    this.roleType,
    this.status,
    this.page = 1,
    this.count = 0,
    this.hasNext = false,
    this.hasPrevious = false,
  });

  final List<PartnerModel> items;
  final bool loading;
  final String? error;
  final String search;
  final PartnerType? partnerType;
  final PartnerRoleType? roleType;
  final PartnerStatus? status;
  final int page;
  final int count;
  final bool hasNext;
  final bool hasPrevious;

  PartnerListState copyWith({
    List<PartnerModel>? items,
    bool? loading,
    String? error,
    String? search,
    PartnerType? partnerType,
    PartnerRoleType? roleType,
    PartnerStatus? status,
    int? page,
    int? count,
    bool? hasNext,
    bool? hasPrevious,
    bool clearError = false,
    bool clearPartnerType = false,
    bool clearRoleType = false,
    bool clearStatus = false,
  }) => PartnerListState(
    items: items ?? this.items,
    loading: loading ?? this.loading,
    error: clearError ? null : error ?? this.error,
    search: search ?? this.search,
    partnerType: clearPartnerType ? null : partnerType ?? this.partnerType,
    roleType: clearRoleType ? null : roleType ?? this.roleType,
    status: clearStatus ? null : status ?? this.status,
    page: page ?? this.page,
    count: count ?? this.count,
    hasNext: hasNext ?? this.hasNext,
    hasPrevious: hasPrevious ?? this.hasPrevious,
  );
}

class PartnerListNotifier extends StateNotifier<PartnerListState> {
  PartnerListNotifier(this._repository) : super(const PartnerListState());

  final PartnerRepository _repository;

  Future<void> load({int? page}) async {
    state = state.copyWith(loading: true, clearError: true);
    try {
      final result = await _repository.listPartners(
        search: state.search,
        partnerType: state.partnerType,
        roleType: state.roleType,
        status: state.status,
        page: page ?? state.page,
      );
      state = state.copyWith(
        items: result.items,
        loading: false,
        page: result.page,
        count: result.count,
        hasNext: result.hasNext,
        hasPrevious: result.hasPrevious,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(loading: false, error: error.toString());
    }
  }

  Future<void> search(String value) async {
    state = state.copyWith(search: value, page: 1);
    await load(page: 1);
  }

  Future<void> setFilters({
    PartnerType? partnerType,
    PartnerRoleType? roleType,
    PartnerStatus? status,
    bool clearPartnerType = false,
    bool clearRoleType = false,
    bool clearStatus = false,
  }) async {
    state = state.copyWith(
      partnerType: partnerType,
      roleType: roleType,
      status: status,
      clearPartnerType: clearPartnerType,
      clearRoleType: clearRoleType,
      clearStatus: clearStatus,
      page: 1,
    );
    await load(page: 1);
  }
}

final partnerListProvider =
    StateNotifierProvider<PartnerListNotifier, PartnerListState>((ref) {
      return PartnerListNotifier(ref.watch(partnerRepositoryProvider));
    });
