import 'package:flutter/foundation.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';

import '../dto/zone_dto.dart';

class ZoneApiService {
  ZoneApiService(
    BsApiClient client,
  ) : _crud = BsCrudApiService(
          client: client,
          basePath:
              '/api/erp-organization/organization/zones/',
        );

  final BsCrudApiService _crud;

  Future<List<ZoneDto>> getZones({
    int? regionId,
  }) async {
    final response =
        await _crud.list(
      queryParameters: {
        'is_active': true,

        if (regionId != null)
          'region': regionId,
      },
    );

    debugPrint(
      'ZONE API RESPONSE: $response',
    );

    final results =
        response['results'];

    if (results is! List) {
      return <ZoneDto>[];
    }

    return results
        .whereType<Map>()
        .map(
          (item) => ZoneDto.fromJson(
            Map<String, dynamic>.from(
              item,
            ),
          ),
        )
        .where(
          (zone) => zone.isActive,
        )
        .toList();
  }
}