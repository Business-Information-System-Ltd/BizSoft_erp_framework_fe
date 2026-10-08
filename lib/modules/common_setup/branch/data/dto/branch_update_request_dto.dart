/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_update_request_dto.dart
 Purpose      : Branch update request DTO.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/


class BranchUpdateRequestDto {
  const BranchUpdateRequestDto({
    required this.legalEntity,
    required this.branchCode,
    required this.branchName,
    required this.branchType,

    this.region,
    this.zone,
    this.address,

    this.latitude,
    this.longitude,

    required this.isHeadOffice,
    required this.isBankBranch,
     required this.isCostCenter,
    required this.isProfitCenter,
     required this.isInventoryStorable,
    required this.isAssetAssignable,
     required this.effectiveFrom,
    required this.effectiveTo,
    required this.isActive,
  });

  final int legalEntity;

  final String branchCode;
  final String branchName;
  final String branchType;

  final int? region;
  final int? zone;
  final int? address;

  final double? latitude;
  final double? longitude;

  final bool isHeadOffice;
  final bool isBankBranch;
  final bool isCostCenter;
  final bool isProfitCenter;
  final bool isAssetAssignable;
  final bool isInventoryStorable;
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;
  final bool isActive;

  Map<String, dynamic> toJson() {
    return {
      'legal_entity': legalEntity,

      'branch_code': branchCode,
      'branch_name': branchName,
      'branch_type': branchType,

      'region': region,
      'zone': zone,
      'address': address,

      'latitude': latitude,
      'longitude': longitude,

      'is_head_office': isHeadOffice,
      'is_bank_branch': isBankBranch,
      'is_active': isActive,
    };
  }
}