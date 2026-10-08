/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : legal_entity_repository.dart
 Purpose      : Legal Entity data repository.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import '../../domain/model/legal_entity.dart';

import '../mapper/legal_entity_mapper.dart';
import '../service/legal_entity_api_service.dart';

class LegalEntityRepository {
  const LegalEntityRepository(
    this._apiService,
  );

  final LegalEntityApiService _apiService;

  Future<List<LegalEntity>>
      getLegalEntities() async {
    final dtos =
        await _apiService
            .getLegalEntities();

    return dtos
        .map(
          LegalEntityMapper.fromDto,
        )
        .toList();
  }

  Future<LegalEntity>
      getLegalEntityById(
    int id,
  ) async {
    final dto =
        await _apiService
            .getLegalEntityById(
      id,
    );

    return LegalEntityMapper.fromDto(
      dto,
    );
  }
}