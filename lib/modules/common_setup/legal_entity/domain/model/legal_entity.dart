/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : legal_entity.dart
 Purpose      : Legal Entity domain model.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

class LegalEntity {
  const LegalEntity({
    required this.id,
    required this.legalEntityCode,
    required this.legalEntityName,
    required this.legalName,
    required this.registrationNo,
    required this.taxRegistrationNo,
    required this.countryCode,
    required this.functionalCurrencyCode,
    required this.presentationCurrencyCode,
    required this.financialYearStartMonth,
    required this.financialYearStartDay,
    required this.legalForm,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
    this.organizationUnit,
    this.parentGroup,
  });

  final int id;

  final String legalEntityCode;
  final String legalEntityName;

  final String legalName;
  final String registrationNo;
  final String taxRegistrationNo;

  final String countryCode;

  final String functionalCurrencyCode;
  final String presentationCurrencyCode;

  final int financialYearStartMonth;
  final int financialYearStartDay;

  final String legalForm;

  final bool isActive;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final int? organizationUnit;
  final int? parentGroup;

  String get displayName {
    if (legalEntityCode.isEmpty) {
      return legalEntityName;
    }

    if (legalEntityName.isEmpty) {
      return legalEntityCode;
    }

    return '$legalEntityName';
  }
}