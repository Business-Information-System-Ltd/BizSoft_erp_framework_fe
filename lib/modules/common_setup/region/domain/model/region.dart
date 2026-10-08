class Region {
  const Region({
    required this.id,
    required this.regionCode,
    required this.regionName,
    this.timezoneName,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.mapLatitude,
    this.mapLongitude,
  });

  final int id;

  final String regionCode;
  final String regionName;

  final String? timezoneName;

  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? mapLatitude;
  final double? mapLongitude;
}