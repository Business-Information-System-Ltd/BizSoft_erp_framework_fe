/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_repository.dart
 Purpose      : Branch use-case level data access.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/

import '../../domain/model/branch.dart';
import '../dto/branch_create_request_dto.dart';
import '../dto/branch_update_request_dto.dart';
import '../mapper/branch_mapper.dart';
import '../service/branch_api_service.dart';

class BranchRepository {
  const BranchRepository(this._apiService);

  final BranchApiService _apiService;

  Future<List<Branch>> getBranches({
    int? legalEntityId,
    String? status,
    String? branchType,
    String? search,
  }) async {
    final dtos = await _apiService.getBranches(
      legalEntityId: legalEntityId,
      status: status,
      branchType: branchType,
      search: search,
    );

    return dtos.map(BranchMapper.fromDto).toList();
  }

  Future<Branch> getBranchById(int id) async {
    final dto = await _apiService.getBranchById(id);

    return BranchMapper.fromDto(dto);
  }

  Future<Branch> createBranch({
    required int legalEntity,

    required String branchCode,
    required String branchName,
    required String branchType,

    int? region,
    int? zone,
    int? address,

    double? latitude,
    double? longitude,

    required bool isHeadOffice,
    required bool isBankBranch,
    required bool isCostCenter,
    required bool isProfitCenter,
    required bool isAssetAssignable,
    required bool isInventoryStorable,
    required DateTime? effectiveFrom,
    required DateTime? effectiveTo,
    required bool isActive,
  }) async {
    final dto = BranchCreateRequestDto(
      legalEntity: legalEntity,

      branchCode: branchCode,

      branchName: branchName,

      branchType: branchType,

      region: region,

      zone: zone,

      address: address,

      latitude: latitude,

      longitude: longitude,

      isHeadOffice: isHeadOffice,

      isBankBranch: isBankBranch,
      isCostCenter: isCostCenter,
      isProfitCenter: isProfitCenter,
      isAssetAssignable: isAssetAssignable,
      isInventoryStorable: isInventoryStorable,
      effectiveFrom: effectiveFrom,
      effectiveTo: effectiveTo,

      isActive: isActive,
    );

    final response = await _apiService.createBranch(dto);

    return BranchMapper.fromDto(response);
  }

  Future<Branch> updateBranch({
    required int id,

    required int legalEntity,

    required String branchCode,
    required String branchName,
    required String branchType,

    int? region,
    int? zone,
    int? address,

    double? latitude,
    double? longitude,

    required bool isHeadOffice,
    required bool isBankBranch,
    required bool isCostCenter,
    required bool isProfitCenter,
    required bool isAssetAssignable,
    required bool isInventoryStorable,
    required DateTime? effectiveFrom,
    required DateTime? effectiveTo,
    required bool isActive,
  }) async {
    final dto = BranchUpdateRequestDto(
      legalEntity: legalEntity,

      branchCode: branchCode,

      branchName: branchName,

      branchType: branchType,

      region: region,

      zone: zone,

      address: address,

      latitude: latitude,

      longitude: longitude,

      isHeadOffice: isHeadOffice,

      isBankBranch: isBankBranch,

      isCostCenter: isCostCenter,

      isProfitCenter: isProfitCenter,
      isAssetAssignable: isAssetAssignable,
      isInventoryStorable: isInventoryStorable,
      effectiveFrom: effectiveFrom,
      effectiveTo: effectiveTo,

      isActive: isActive,
    );

    final response = await _apiService.updateBranch(id, dto);

    return BranchMapper.fromDto(response);
  }

  Future<void> deleteBranch(int id) {
    return _apiService.deleteBranch(id);
  }
}
