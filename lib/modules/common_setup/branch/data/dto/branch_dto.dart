import '../../../address/data/dto/address_dto.dart';
import '../../../address/domain/model/address.dart';
import '../../../region/data/dto/region_dto.dart';
import '../../../region/domain/model/region.dart';
import '../../../zone/data/dto/zone_dto.dart';
import '../../../zone/domain/model/zone.dart';

class BranchDto {
  const BranchDto({
    required this.id,
    this.organizationUnit,

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

  static int? _int(dynamic value) {
    if (value == null) return null;

    if (value is int) return value;

    return int.tryParse(value.toString());
  }

  static double? _double(dynamic value) {
    if (value == null) return null;

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static bool _bool(dynamic value) {
    if (value is bool) return value;

    if (value is num) {
      return value != 0;
    }

    final text =
        value?.toString().toLowerCase().trim();

    return text == 'true' ||
        text == '1' ||
        text == 'yes';
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;

    return DateTime.tryParse(
      value.toString(),
    );
  }

  factory BranchDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return BranchDto(
      id: _int(json['id']) ?? 0,

      organizationUnit:
          _int(json['organization_unit']),

      branchCode:
          json['branch_code']?.toString() ?? '',

      branchName:
          json['branch_name']?.toString() ?? '',

      legalEntity:
          _int(json['legal_entity']) ?? 0,

      branchType:
          json['branch_type']?.toString() ?? '',

      region:
          _int(json['region']),

      
       regionDetail:
          json['region_detail'] != null
              ? RegionDto.fromJson(
                  json['region_detail'],
                ).toDomain()
              : null,       

      zone:
          _int(json['zone']),

      zoneDetail:
          json['zone_detail'] != null
              ? ZoneDto.fromJson(
                  json['zone_detail'],
                ).toDomain()
              : null,

      address:
          _int(json['address']),

      addressDetail:
          json['address_detail'] != null
              ? AddressDto.fromJson(
                  json['address_detail'],
                ).toDomain()
              : null,

      latitude:
          _double(json['latitude']),

      longitude:
          _double(json['longitude']),

      isHeadOffice:
          _bool(json['is_head_office']),

      isBankBranch:
          _bool(json['is_bank_branch']),

      isActive:
          _bool(json['is_active']),

      isCostCenter:
          _bool(json['is_cost_center']),

      isProfitCenter:
          _bool(json['is_profit_center']),

      isInventoryStorable:
          _bool(json['is_inventory_storable']),

      isAssetAssignable:
          _bool(json['is_asset_assignable']),

      effectiveFrom:
          _date(json['effective_from']),

      effectiveTo:
          _date(json['effective_to']),

      createdBy:
          json['created_by']?.toString(),

      updatedBy:
          json['updated_by']?.toString(),

      createdAt:
          _date(json['created_at']),

      updatedAt:
          _date(json['updated_at']),
    );
  }
}