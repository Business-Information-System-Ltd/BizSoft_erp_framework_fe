/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : legal_entity_mapper.dart
 Purpose      : Maps Legal Entity DTO to domain model.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import '../../domain/model/legal_entity.dart';
import '../dto/legal_entity_dto.dart';

class LegalEntityMapper {
  const LegalEntityMapper._();

  static LegalEntity fromDto(
    LegalEntityDto dto,
  ) {
    return LegalEntity(
      id: dto.id,
      legalEntityCode:
          dto.legalEntityCode,
      legalEntityName:
          dto.legalEntityName,
      legalName:
          dto.legalName,
      registrationNo:
          dto.registrationNo,
      taxRegistrationNo:
          dto.taxRegistrationNo,
      countryCode:
          dto.countryCode,
      functionalCurrencyCode:
          dto.functionalCurrencyCode,
      presentationCurrencyCode:
          dto.presentationCurrencyCode,
      financialYearStartMonth:
          dto.financialYearStartMonth,
      financialYearStartDay:
          dto.financialYearStartDay,
      legalForm:
          dto.legalForm,
      isActive:
          dto.isActive,
      createdAt:
          dto.createdAt,
      updatedAt:
          dto.updatedAt,
      organizationUnit:
          dto.organizationUnit,
      parentGroup:
          dto.parentGroup,
    );
  }
}