/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_api_service.dart
 Purpose      : Branch endpoint calls.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/

import 'package:flutter/material.dart';

import '../../../../../core/api/bs_api_client.dart';
import '../../../../../core/api/bs_crud_api_service.dart';

import '../dto/branch_create_request_dto.dart';
import '../dto/branch_dto.dart';
import '../dto/branch_update_request_dto.dart';

class BranchApiService {
  BranchApiService(BsApiClient client)
      : _crud = BsCrudApiService(
          client: client,
          basePath:
              '/api/erp-organization/organization/branches/',
        );

  final BsCrudApiService _crud;

Future<List<BranchDto>> getBranches({
  int? legalEntityId,
  String? branchType,
  String? status,
  String? search,
}) async {
  final queryParameters = <String, dynamic>{};
  if (legalEntityId != null) {
      queryParameters[
        'legal_entity'
      ] = legalEntityId;
    }
    
  

  if (branchType != null && branchType.trim().isNotEmpty) {
    queryParameters['branch_type'] = branchType.trim();
  }

  if (status != null && status.trim().isNotEmpty) {
    queryParameters['is_active'] = status.trim();
  }

  if (search != null && search.trim().isNotEmpty) {
    queryParameters['search'] = search.trim();
  }

  debugPrint('BRANCH FILTER PARAMS: $queryParameters');

  final response = await _crud.list(
    queryParameters: queryParameters,
  );

  debugPrint('BRANCH API RESPONSE: $response');

  final results = response['results'];

  if (results is! List) {
    return <BranchDto>[];
  }

  return results
      .whereType<Map>()
      .map(
        (item) => BranchDto.fromJson(
          Map<String, dynamic>.from(item),
        ),
      )
      .toList();
}
  Future<BranchDto> getBranchById(int id) async {
    final response = await _crud.getById(id);
    return BranchDto.fromJson(response);
  }

  Future<BranchDto> createBranch(
    BranchCreateRequestDto dto,
  ) async {
    debugPrint(
      'BRANCH CREATE REQUEST: '
      '${dto.toJson()}',
    );

    final response =
        await _crud.create(
      dto.toJson(),
    );

    debugPrint(
      'BRANCH CREATE RESPONSE: '
      '$response',
    );

    return BranchDto.fromJson(
      response,
    );
  }

  Future<BranchDto> updateBranch(
    int id,
    BranchUpdateRequestDto dto,
  ) async {
    debugPrint(
      'BRANCH UPDATE REQUEST: '
      '${dto.toJson()}',
    );

    final response =
        await _crud.update(
      id,
      dto.toJson(),
    );

    debugPrint(
      'BRANCH UPDATE RESPONSE: '
      '$response',
    );

    return BranchDto.fromJson(
      response,
    );
  }

  Future<void> deleteBranch(
    int id,
  ) {
    return _crud.delete(id);
  }

  Future<void> updateBranchStatus({
    required int id,
    required bool isActive,
  }) async {
    await _crud.patch(
      id,
      {
        'is_active': isActive,
      },
    );
  }
}