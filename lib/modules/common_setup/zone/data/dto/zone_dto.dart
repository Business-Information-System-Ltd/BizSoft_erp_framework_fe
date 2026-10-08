import '../../domain/model/zone.dart';

class ZoneDto {
  const ZoneDto({
    required this.id,
    required this.zoneCode,
    required this.zoneName,
    required this.regionId,
    required this.timezoneAbbreviation,
    required this.utcOffset,
    required this.isActive,
    this.mapLatitude,
    this.mapLongitude,
  });

  final int id;

  final String zoneCode;
  final String zoneName;

  final int? regionId;

  final String timezoneAbbreviation;
  final String utcOffset;

  final bool isActive;

  final double? mapLatitude;
  final double? mapLongitude;

  factory ZoneDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return ZoneDto(
      id:
          _toInt(json['id']) ?? 0,

      zoneCode:
          json['zone_code']?.toString() ?? '',

      zoneName:
          json['zone_name']?.toString() ?? '',

      regionId:
          _toInt(json['region']),

      timezoneAbbreviation:
          json['timezone_abbreviation']
                  ?.toString() ??
              '',

      utcOffset:
          json['utc_offset']?.toString() ?? '',

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
    final parts =
        <String>[];

    if (zoneName.isNotEmpty) {
      parts.add(zoneName);
    }

    if (timezoneAbbreviation.isNotEmpty) {
      parts.add(
        timezoneAbbreviation,
      );
    }

    if (utcOffset.isNotEmpty) {
      parts.add(
        'UTC$utcOffset',
      );
    }

    return parts.join(' ');
  }

  Zone toDomain() {
    return Zone(
      id: id,
      zoneCode: zoneCode,
      zoneName: zoneName,
      region: regionId ?? 0,
      timezoneAbbreviation:
          timezoneAbbreviation,
      utcOffset:
          utcOffset,
      isActive:
          isActive,
      mapLatitude:
          mapLatitude,
      mapLongitude:
          mapLongitude,
    );
  }
}