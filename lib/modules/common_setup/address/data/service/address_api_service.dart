import 'package:flutter/foundation.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';
import '../dto/address_dto.dart';

class AddressApiService {
  AddressApiService(BsApiClient client)
      : _crud = BsCrudApiService(
          client: client,
          basePath: '/api/erp-organization/organization/addresses/',
        );

  final BsCrudApiService _crud;

  Future<AddressDto> createAddress(AddressDto dto) async {
    debugPrint('ADDRESS CREATE REQUEST: ${dto.toJson()}');
    final response = await _crud.create(dto.toJson());
    debugPrint('ADDRESS CREATE RESPONSE: $response');
    return AddressDto.fromJson(response);
  }

  Future<AddressDto> updateAddress(int id, AddressDto dto) async {
    debugPrint('ADDRESS UPDATE REQUEST: ${dto.toJson()}');
    final response = await _crud.update(id, dto.toJson());
    debugPrint('ADDRESS UPDATE RESPONSE: $response');
    return AddressDto.fromJson(response);
  }
}
