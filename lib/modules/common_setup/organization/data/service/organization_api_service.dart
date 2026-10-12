import 'package:flutter/foundation.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';

class OrganizationApiService {
  OrganizationApiService(BsApiClient client)
    : _crud = BsCrudApiService(client: client, basePath: '/api/organizations/');

  final BsCrudApiService _crud;

  Future<Map<String, dynamic>> list({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _crud.list(queryParameters: queryParameters);
    debugPrint('ORGANIZATION API RESPONSE: $response');
    return response;
  }

  Future<Map<String, dynamic>> getById(int id) => _crud.getById(id);
  Future<Map<String, dynamic>> create(Map<String, dynamic> p) =>
      _crud.create(p);
  Future<Map<String, dynamic>> update(int id, Map<String, dynamic> p) =>
      _crud.update(id, p);
  Future<void> delete(int id) => _crud.delete(id);
}
