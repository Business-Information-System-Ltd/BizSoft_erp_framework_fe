import '../../domain/model/address.dart';
import '../../../region/data/dto/region_dto.dart';
import '../../../zone/data/dto/zone_dto.dart';

class AddressDto {
  const AddressDto({
    this.id,
    this.addressLine1 = '',
    this.addressLine2,
    this.township = '',
    this.city = '',
    this.regionId,
    this.regionDetail,
    this.zoneId,
    this.zoneDetail,
    this.postalCode,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String addressLine1;
  final String? addressLine2;
  final String township;
  final String city;
  final int? regionId;
  final RegionDto? regionDetail;
  final int? zoneId;
  final ZoneDto? zoneDetail;
  final String? postalCode;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AddressDto.fromJson(Map<String, dynamic> json) {
    return AddressDto(
      id: _toInt(json['id']),
      addressLine1: json['address_line_1']?.toString() ?? '',
      addressLine2: _nullableString(json['address_line_2']?.toString()),
      township: json['township']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      regionId: _toInt(json['region']),
      regionDetail: json['region_detail'] is Map
          ? RegionDto.fromJson(
              Map<String, dynamic>.from(json['region_detail'] as Map),
            )
          : null,
      zoneId: _toInt(json['zone']),
      zoneDetail: json['zone_detail'] is Map
          ? ZoneDto.fromJson(
              Map<String, dynamic>.from(json['zone_detail'] as Map),
            )
          : null,
      postalCode: _nullableString(json['postal_code']?.toString()),
      isActive: _toBool(json['is_active']),
      createdAt: _toDate(json['created_at']),
      updatedAt: _toDate(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address_line_1': addressLine1.trim(),
      'address_line_2': _nullableString(addressLine2),
      'township': township.trim(),
      'city': city.trim(),
      'region': regionId,
      'zone': zoneId,
      'postal_code': _nullableString(postalCode),
      'is_active': isActive,
    };
  }

  Address toDomain() {
    return Address(
      id: id ?? 0,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      township: township,
      city: city,
      region: regionId ?? 0,
      regionDetail: regionDetail?.toDomain(),
      zone: zoneId ?? 0,
      zoneDetail: zoneDetail?.toDomain(),
      postalCode: postalCode,
      isActive: isActive,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    if (value is num) return value != 0;
    final text = value?.toString().toLowerCase().trim();
    return text == 'true' || text == '1' || text == 'yes';
  }

  static DateTime? _toDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static String? _nullableString(String? value) {
    if (value == null) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
