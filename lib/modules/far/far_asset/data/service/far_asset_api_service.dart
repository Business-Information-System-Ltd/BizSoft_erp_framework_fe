import 'package:flutter/material.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';

import '../dto/far_asset_create_request_dto.dart';
import '../dto/far_asset_dto.dart';
import '../dto/far_asset_update_request_dto.dart';

class FarAssetApiService {
  FarAssetApiService(BsApiClient client)
    : _crud = BsCrudApiService(
        client: client,
        basePath: '/api/erp-far/far/assets/',
      ),
      _coreEntityCrud = BsCrudApiService(
        client: client,
        basePath: '/api/core-entity/',
      ),
      _organizationCrud = BsCrudApiService(
        client: client,
        basePath: '/api/organizations/units/',
      ),
      _partnerCrud = BsCrudApiService(
        client: client,
        basePath: '/api/partners/',
      );

  final BsCrudApiService _crud;
  final BsCrudApiService _coreEntityCrud;
  final BsCrudApiService _organizationCrud;
  final BsCrudApiService _partnerCrud;

  Future<List<FarAssetDto>> getFarAssets({
    String? status,
    String? assetType,
    String? search,
  }) async {
    final queryParameters = <String, dynamic>{};

    if (status != null && status.trim().isNotEmpty) {
      queryParameters['status'] = status.trim();
    }

    if (assetType != null && assetType.trim().isNotEmpty) {
      queryParameters['asset_type'] = assetType.trim();
    }

    if (search != null && search.trim().isNotEmpty) {
      queryParameters['search'] = search.trim();
    }

    debugPrint('FAR ASSET FILTER PARAMS: $queryParameters');

    final response = await _crud.list(queryParameters: queryParameters);

    debugPrint('FAR ASSET API RESPONSE: $response');

    final results = response['results'];

    if (results is! List) {
      return <FarAssetDto>[];
    }

    return results
        .whereType<Map>()
        .map((item) => FarAssetDto.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<FarAssetDto> getFarAssetById(int id) async {
    final response = await _crud.getById(id);
    return FarAssetDto.fromJson(response);
  }

  Future<FarAssetDto> createFarAsset(FarAssetCreateRequestDto dto) async {
    debugPrint('FAR ASSET CREATE REQUEST: ${dto.toJson()}');

    final response = await _crud.create(dto.toJson());

    debugPrint('FAR ASSET CREATE RESPONSE: $response');

    return FarAssetDto.fromJson(response);
  }

  Future<FarAssetDto> updateFarAsset(
    int id,
    FarAssetUpdateRequestDto dto,
  ) async {
    debugPrint('FAR ASSET UPDATE REQUEST: ${dto.toJson()}');

    final response = await _crud.update(id, dto.toJson());

    debugPrint('FAR ASSET UPDATE RESPONSE: $response');

    return FarAssetDto.fromJson(response);
  }

  Future<void> deleteFarAsset(int id) {
    return _crud.delete(id);
  }

  Future<void> updateFarAssetStatus({
    required int id,
    required String status,
  }) async {
    await _crud.patch(id, {'status': status});
  }

  Future<List<Map<String, dynamic>>> getLegalEntities({
    Map<String, dynamic>? query,
  }) async {
    final response = await _coreEntityCrud.list(queryParameters: query);

    debugPrint('CORE ENTITY RESPONSE: $response');

    final results = response['results'];

    if (results is! List) return [];

    return results
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getOrganizations({
    Map<String, dynamic>? query,
  }) async {
    final response = await _organizationCrud.list(queryParameters: query);

    debugPrint('ORGANIZATION RESPONSE: $response');

    final results = response['results'];

    if (results is! List) return [];

    return results
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  Future<List<Map<String, dynamic>>> getPartners({
    Map<String, dynamic>? query,
  }) async {
    final response = await _partnerCrud.list(queryParameters: query);

    debugPrint('PARTNER RESPONSE: $response');

    final results = response['results'];

    if (results is! List) return [];

    return results
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
