/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_contact_model.dart
 Purpose      : *   Models contact points for partners.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class PartnerContactModel {
  const PartnerContactModel({
    this.id,
    this.contactType,
    this.value,
    this.personName,
    this.isPrimary = false,
  });

  final String? id;
  final String? contactType;
  final String? value;
  final String? personName;
  final bool isPrimary;

  factory PartnerContactModel.fromJson(Map<String, dynamic> json) => PartnerContactModel(
        id: json['id']?.toString(),
        contactType: json['contact_type']?.toString(),
        value: json['value']?.toString(),
        personName: json['person_name']?.toString(),
        isPrimary: json['is_primary'] == true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'contact_type': contactType,
        'value': value,
        'person_name': personName,
        'is_primary': isPrimary,
      };

  PartnerContactModel copyWith({
    String? id,
    String? contactType,
    String? value,
    String? personName,
    bool? isPrimary,
  }) =>
      PartnerContactModel(
        id: id ?? this.id,
        contactType: contactType ?? this.contactType,
        value: value ?? this.value,
        personName: personName ?? this.personName,
        isPrimary: isPrimary ?? this.isPrimary,
      );
}
