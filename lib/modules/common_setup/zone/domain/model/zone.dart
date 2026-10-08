class Zone {
  const Zone({
    required this.id,
    required this.zoneCode,
    required this.zoneName,
    required this.region,
    this.timezoneAbbreviation,
    this.utcOffset,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.mapLatitude,
    this.mapLongitude,
  });

  final int id;

  final String zoneCode;
  final String zoneName;

  final int region;

  final String? timezoneAbbreviation;
  final String? utcOffset;

  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  
  final double? mapLatitude;
  final double? mapLongitude;
}