/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_registration_model.dart
 Purpose      : *   Models tax, company, and statutory registrations for partners.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'model_helpers.dart';

class PartnerRegistrationModel {
  const PartnerRegistrationModel({
    this.id,
    this.registrationType,
    this.registrationNumber,
    this.countryCode,
    this.validFrom,
    this.validTo,
  });

  final String? id;
  final String? registrationType;
  final String? registrationNumber;
  final String? countryCode;
  final DateTime? validFrom;
  final DateTime? validTo;

  factory PartnerRegistrationModel.fromJson(Map<String, dynamic> json) => PartnerRegistrationModel(
        id: json['id']?.toString(),
        registrationType: json['registration_type']?.toString(),
        registrationNumber: json['registration_number']?.toString(),
        countryCode: json['country_code']?.toString(),
        validFrom: parseDate(json['valid_from']),
        validTo: parseDate(json['valid_to']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'registration_type': registrationType,
        'registration_number': registrationNumber,
        'country_code': countryCode,
        'valid_from': dateToJson(validFrom),
        'valid_to': dateToJson(validTo),
      };

  PartnerRegistrationModel copyWith({
    String? id,
    String? registrationType,
    String? registrationNumber,
    String? countryCode,
    DateTime? validFrom,
    DateTime? validTo,
  }) =>
      PartnerRegistrationModel(
        id: id ?? this.id,
        registrationType: registrationType ?? this.registrationType,
        registrationNumber: registrationNumber ?? this.registrationNumber,
        countryCode: countryCode ?? this.countryCode,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
      );
}
