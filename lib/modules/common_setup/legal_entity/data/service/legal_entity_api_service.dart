/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : legal_entity_api_service.dart
 Purpose      : Legal Entity API endpoint calls.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - Legal Entity data comes from the real backend API.
 - User-right filtering is handled by the framework provider.
 - No UI logic is placed here.

===============================================================================
*/

import 'package:flutter/foundation.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';

import '../dto/legal_entity_dto.dart';

class LegalEntityApiService {
  LegalEntityApiService(
    BsApiClient client,
  ) : _crud = BsCrudApiService(
          client: client,
          basePath:
              '/api/erp-organization/organization/legal-entities/',
        );

  final BsCrudApiService _crud;

  Future<List<LegalEntityDto>>
      getLegalEntities() async {
    final response =
        await _crud.list();

    debugPrint(
      'LEGAL ENTITY API RESPONSE: $response',
    );

    final results =
        response['results'];

    if (results is! List) {
      return <LegalEntityDto>[];
    }

    return results
        .whereType<Map>()
        .map(
          (item) {
            return LegalEntityDto.fromJson(
              Map<String, dynamic>.from(
                item,
              ),
            );
          },
        )
        .toList();
  }

  Future<LegalEntityDto>
      getLegalEntityById(
    int id,
  ) async {
    final response =
        await _crud.getById(id);

    return LegalEntityDto.fromJson(
      response,
    );
  }
}