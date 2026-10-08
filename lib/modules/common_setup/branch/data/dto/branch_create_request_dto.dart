/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_create_request_dto.dart
 Purpose      : Branch create request DTO.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/



class BranchCreateRequestDto {
  const BranchCreateRequestDto({
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

    this.effectiveFrom,
    this.effectiveTo,

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
  final bool isInventoryStorable;
  final bool isAssetAssignable;

  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;

  final bool isActive;

  String? _dateOnly(
    DateTime? value,
  ) {
    if (value == null) {
      return null;
    }

    final year =
        value.year.toString().padLeft(
              4,
              '0',
            );

    final month =
        value.month.toString().padLeft(
              2,
              '0',
            );

    final day =
        value.day.toString().padLeft(
              2,
              '0',
            );

    return '$year-$month-$day';
  }

  Map<String, dynamic> toJson() {
    return {
      'legal_entity':
          legalEntity,

      'branch_code':
          branchCode,

      'branch_name':
          branchName,

      'branch_type':
          branchType,

      'region':
          region,

      'zone':
          zone,

      'address':
          address,

      'latitude':
          latitude,

      'longitude':
          longitude,


      'is_head_office':
          isHeadOffice,

      'is_bank_branch':
          isBankBranch,

      'is_cost_center':
          isCostCenter,

      'is_profit_center':
          isProfitCenter,

      'is_inventory_storable':
          isInventoryStorable,

      'is_asset_assignable':
          isAssetAssignable,

      

      'effective_from':
          _dateOnly(
        effectiveFrom,
      ),

      'effective_to':
          _dateOnly(
        effectiveTo,
      ),

      'is_active':
          isActive,
    };
  }
}