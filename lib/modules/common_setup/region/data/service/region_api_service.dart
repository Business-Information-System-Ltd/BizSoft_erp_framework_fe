import 'package:flutter/foundation.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';

import '../dto/region_dto.dart';

class RegionApiService {
  RegionApiService(
    BsApiClient client,
  ) : _crud = BsCrudApiService(
          client: client,
          basePath:
              '/api/erp-organization/organization/regions/',
        );

  final BsCrudApiService _crud;

  Future<List<RegionDto>> getRegions() async {
    final response =
        await _crud.list(
      queryParameters: {
        'is_active': true,
      },
    );

    debugPrint(
      'REGION API RESPONSE: $response',
    );

    final results =
        response['results'];

    if (results is! List) {
      return <RegionDto>[];
    }

    return results
        .whereType<Map>()
        .map(
          (item) => RegionDto.fromJson(
            Map<String, dynamic>.from(
              item,
            ),
          ),
        )
        .where(
          (region) => region.isActive,
        )
        .toList();
  }
}