/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_mapper.dart
 Purpose      : maps Branch DTOs to domain models.
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
import '../dto/branch_dto.dart';

class BranchMapper {
  const BranchMapper._();

  static Branch fromDto(
    BranchDto dto,
  ) {
    return Branch(
      id: dto.id,

      organizationUnit:
          dto.organizationUnit,

      branchCode:
          dto.branchCode,

      branchName:
          dto.branchName,

      legalEntity:
          dto.legalEntity,

      branchType:
          dto.branchType,

      region:
          dto.region,

      regionDetail:
          dto.regionDetail,

      zone:
          dto.zone,

      zoneDetail:
          dto.zoneDetail,

      address:
          dto.address,

      addressDetail:
          dto.addressDetail,

      latitude:
          dto.latitude,

      longitude:
          dto.longitude,

      isHeadOffice:
          dto.isHeadOffice,

      isBankBranch:
          dto.isBankBranch,

      isActive:
          dto.isActive,

      isCostCenter:
          dto.isCostCenter,

      isProfitCenter:
          dto.isProfitCenter,

      isInventoryStorable:
          dto.isInventoryStorable,

      isAssetAssignable:
          dto.isAssetAssignable,

      effectiveFrom:
          dto.effectiveFrom,

      effectiveTo:
          dto.effectiveTo,

      createdBy:
          dto.createdBy,

      updatedBy:
          dto.updatedBy,

      createdAt:
          dto.createdAt,

      updatedAt:
          dto.updatedAt,
    );
  }
}