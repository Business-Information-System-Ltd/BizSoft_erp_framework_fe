import '../../../region/domain/model/region.dart';
import '../../../zone/domain/model/zone.dart';

class Address {
  const Address({
    required this.id,

    required this.addressLine1,
    this.addressLine2,

    required this.township,
    required this.city,

    required this.region,
    this.regionDetail,

    required this.zone,
    this.zoneDetail,

    this.postalCode,

    required this.isActive,

    this.createdAt,
    this.updatedAt,
  });

  final int id;

  final String addressLine1;
  final String? addressLine2;

  final String township;
  final String city;

  final int region;
  final Region? regionDetail;

  final int zone;
  final Zone? zoneDetail;

  final String? postalCode;

  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;
}