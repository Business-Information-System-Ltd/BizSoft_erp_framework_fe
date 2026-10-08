/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch.dart
 Purpose      : Branch domain model.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/

import '../../../address/domain/model/address.dart';
import '../../../region/domain/model/region.dart';
import '../../../zone/domain/model/zone.dart';

class Branch {
  const Branch({
    required this.id,
    required this.organizationUnit,
    required this.branchCode,
    required this.branchName,
    required this.legalEntity,
    required this.branchType,

    this.region,
    this.regionDetail,

    this.zone,
    this.zoneDetail,

    this.address,
    this.addressDetail,

    this.latitude,
    this.longitude,

    required this.isHeadOffice,
    required this.isBankBranch,
    required this.isActive,

    required this.isCostCenter,
    required this.isProfitCenter,
    required this.isInventoryStorable,
    required this.isAssetAssignable,

    this.effectiveFrom,
    this.effectiveTo,

    this.createdBy,
    this.updatedBy,

    this.createdAt,
    this.updatedAt,
  });

  final int id;

  final int? organizationUnit;

  final String branchCode;
  final String branchName;

  final int legalEntity;

  final String branchType;

  
  final int? region;
  final Region? regionDetail;

  final int? zone;
  final Zone? zoneDetail;

  final int? address;
  final Address? addressDetail;


  final double? latitude;
  final double? longitude;

  final bool isHeadOffice;
  final bool isBankBranch;
  final bool isActive;

  final bool isCostCenter;
  final bool isProfitCenter;
  final bool isInventoryStorable;
  final bool isAssetAssignable;

 
  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;

  final String? createdBy;
  final String? updatedBy;

  final DateTime? createdAt;
  final DateTime? updatedAt;
}