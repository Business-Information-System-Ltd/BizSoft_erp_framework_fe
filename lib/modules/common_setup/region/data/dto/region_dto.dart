import '../../domain/model/region.dart';

class RegionDto {
  const RegionDto({
    required this.id,
    required this.regionCode,
    required this.regionName,
    required this.timezoneName,
    required this.isActive,
    this.mapLatitude,
    this.mapLongitude,
  });

  final int id;

  final String regionCode;
  final String regionName;
  final String timezoneName;

  final bool isActive;

  final double? mapLatitude;
  final double? mapLongitude;

  factory RegionDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return RegionDto(
      id:
          _toInt(json['id']) ?? 0,

      regionCode:
          json['region_code']?.toString() ?? '',

      regionName:
          json['region_name']?.toString() ?? '',

      timezoneName:
          json['timezone_name']?.toString() ?? '',

      isActive:
          _toBool(json['is_active']),

      mapLatitude:
          _toDouble(
            json['map_latitude'] ??
                json['latitude'],
          ),

      mapLongitude:
          _toDouble(
            json['map_longitude'] ??
                json['longitude'],
          ),
    );
  }

  static int? _toInt(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    return int.tryParse(
      value.toString(),
    );
  }

  static double? _toDouble(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
      value.toString(),
    );
  }

  static bool _toBool(
    dynamic value,
  ) {
    if (value is bool) {
      return value;
    }

    final text =
        value?.toString().toLowerCase();

    return text == 'true' ||
        text == '1' ||
        text == 'yes';
  }

  String get displayName {
    return regionName.isEmpty
        ? regionCode
        : regionName;
  }

  Region toDomain() {
    return Region(
      id: id,
      regionCode: regionCode,
      regionName: regionName,
      timezoneName: timezoneName,
      isActive: isActive,
      mapLatitude: mapLatitude,
      mapLongitude: mapLongitude,
    );
  }
}