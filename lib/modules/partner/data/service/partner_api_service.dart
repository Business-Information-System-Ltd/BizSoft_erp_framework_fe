/*
 * BizSoft ERP - Business Partner Module
 *
 * File: lib/features/partners/data/services/partner_api_service.dart
 */

import 'package:flutter/foundation.dart';

import '../../../../core/api/bs_api_client.dart';
import '../../../../core/api/bs_crud_api_service.dart';

class PartnerApiService {
  PartnerApiService(BsApiClient client)
    : _crud = BsCrudApiService(client: client, basePath: '/api/partners/');

  final BsCrudApiService _crud;

  /// ✅ list() — dropdown provider က ဒါကို ခေါ်တယ်
  Future<Map<String, dynamic>> list({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _crud.list(queryParameters: queryParameters);
    debugPrint('PARTNER API RESPONSE: $response');
    return response;
  }

  /// Partner-specific list with filters
  Future<Map<String, dynamic>> listPartners({
    String? search,
    String? partnerType,
    String? roleType,
    String? status,
    int page = 1,
  }) {
    return _crud.list(
      queryParameters: {
        'search': search,
        'partner_type': partnerType,
        'role_type': roleType,
        'status': status,
        'page': page,
      },
    );
  }

  Future<Map<String, dynamic>> getPartner(String id) {
    return _crud.getById(id);
  }

  Future<Map<String, dynamic>> createPartner(Map<String, dynamic> data) {
    return _crud.create(data);
  }

  Future<Map<String, dynamic>> updatePartner(
    String id,
    Map<String, dynamic> data,
  ) {
    return _crud.update(id, data);
  }

  Future<Map<String, dynamic>> patchPartner(
    String id,
    Map<String, dynamic> data,
  ) {
    return _crud.patch(id, data);
  }

  Future<void> activatePartner(String id) async {
    await _crud.action(id, 'activate');
  }

  Future<void> blockPartner(String id) async {
    await _crud.action(id, 'block');
  }

  Future<List<Map<String, dynamic>>> listChildRecords(
    String partnerId,
    String childName, {
    Map<String, dynamic>? queryParameters,
  }) {
    return _crud.listChildRecords(
      partnerId,
      childName,
      queryParameters: queryParameters,
    );
  }

  Future<Map<String, dynamic>> createChildRecord(
    String partnerId,
    String childName,
    Map<String, dynamic> data,
  ) {
    return _crud.createChildRecord(partnerId, childName, data);
  }

  Future<Map<String, dynamic>> updateChildRecord(
    String partnerId,
    String childName,
    String childId,
    Map<String, dynamic> data,
  ) {
    return _crud.updateChildRecord(partnerId, childName, childId, data);
  }

  Future<void> deleteChildRecord(
    String partnerId,
    String childName,
    String childId,
  ) {
    return _crud.deleteChildRecord(partnerId, childName, childId);
  }
}
