import '../../domain/model/region.dart';

import '../service/region_api_service.dart';

class RegionRepository {
  const RegionRepository(
    this._service,
  );

  final RegionApiService _service;

  Future<List<Region>> getRegions() async {
    final dtos =
        await _service.getRegions();

    return dtos
        .map(
          (dto) => dto.toDomain(),
        )
        .toList();
  }
}