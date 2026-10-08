/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : legal_entity_dto.dart
 Purpose      : Legal Entity API response DTO.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

class LegalEntityDto {
  const LegalEntityDto({
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

  factory LegalEntityDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return LegalEntityDto(
      id: _toInt(
        json['id'],
      ),

      legalEntityCode:
          json['legal_entity_code']
                  ?.toString() ??
              '',

      legalEntityName:
          json['legal_entity_name']
                  ?.toString() ??
              '',

      legalName:
          json['legal_name']
                  ?.toString() ??
              '',

      registrationNo:
          json['registration_no']
                  ?.toString() ??
              '',

      taxRegistrationNo:
          json['tax_registration_no']
                  ?.toString() ??
              '',

      countryCode:
          json['country_code']
                  ?.toString() ??
              '',

      functionalCurrencyCode:
          json['functional_currency_code']
                  ?.toString() ??
              '',

      presentationCurrencyCode:
          json['presentation_currency_code']
                  ?.toString() ??
              '',

      financialYearStartMonth:
          _toInt(
        json[
          'financial_year_start_month'
        ],
      ),

      financialYearStartDay:
          _toInt(
        json[
          'financial_year_start_day'
        ],
      ),

      legalForm:
          json['legal_form']
                  ?.toString() ??
              '',

      isActive:
          _toBool(
        json['is_active'],
      ),

      createdAt:
          _toDateTime(
        json['created_at'],
      ),

      updatedAt:
          _toDateTime(
        json['updated_at'],
      ),

      organizationUnit:
          _toNullableInt(
        json['organization_unit'],
      ),

      parentGroup:
          _toNullableInt(
        json['parent_group'],
      ),
    );
  }

  static int _toInt(
    dynamic value,
  ) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static int? _toNullableInt(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(
      value.toString(),
    );
  }

  static bool _toBool(
    dynamic value,
  ) {
    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    if (value is String) {
      final normalized =
          value.trim().toLowerCase();

      return normalized == 'true' ||
          normalized == '1' ||
          normalized == 'yes';
    }

    return false;
  }

  static DateTime? _toDateTime(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    return DateTime.tryParse(
      value.toString(),
    );
  }
}