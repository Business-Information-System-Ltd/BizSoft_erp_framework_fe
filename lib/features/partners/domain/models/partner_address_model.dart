/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_address_model.dart
 Purpose      : *   Models postal and physical addresses for partners.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class PartnerAddressModel {
  const PartnerAddressModel({
    this.id,
    this.addressType,
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.postalCode,
    this.countryCode,
    this.isPrimary = false,
  });

  final String? id;
  final String? addressType;
  final String? line1;
  final String? line2;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? countryCode;
  final bool isPrimary;

  factory PartnerAddressModel.fromJson(Map<String, dynamic> json) => PartnerAddressModel(
        id: json['id']?.toString(),
        addressType: json['address_type']?.toString(),
        line1: json['line1']?.toString(),
        line2: json['line2']?.toString(),
        city: json['city']?.toString(),
        state: json['state']?.toString(),
        postalCode: json['postal_code']?.toString(),
        countryCode: json['country_code']?.toString(),
        isPrimary: json['is_primary'] == true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'address_type': addressType,
        'line1': line1,
        'line2': line2,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'country_code': countryCode,
        'is_primary': isPrimary,
      };

  PartnerAddressModel copyWith({
    String? id,
    String? addressType,
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? postalCode,
    String? countryCode,
    bool? isPrimary,
  }) =>
      PartnerAddressModel(
        id: id ?? this.id,
        addressType: addressType ?? this.addressType,
        line1: line1 ?? this.line1,
        line2: line2 ?? this.line2,
        city: city ?? this.city,
        state: state ?? this.state,
        postalCode: postalCode ?? this.postalCode,
        countryCode: countryCode ?? this.countryCode,
        isPrimary: isPrimary ?? this.isPrimary,
      );
}
