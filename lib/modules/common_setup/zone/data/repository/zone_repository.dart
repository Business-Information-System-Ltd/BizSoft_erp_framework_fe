import '../../domain/model/zone.dart';

import '../service/zone_api_service.dart';

class ZoneRepository {
  const ZoneRepository(
    this._service,
  );

  final ZoneApiService _service;

  Future<List<Zone>> getZones({
    int? regionId,
  }) async {
    final dtos =
        await _service.getZones(
      regionId: regionId,
    );

    return dtos
        .map(
          (dto) => dto.toDomain(),
        )
        .toList();
  }
}