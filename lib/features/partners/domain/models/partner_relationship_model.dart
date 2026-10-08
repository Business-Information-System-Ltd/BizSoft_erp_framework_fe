/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_relationship_model.dart
 Purpose      : *   Models relationships between business partners.
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

class PartnerRelationshipModel {
  const PartnerRelationshipModel({
    this.id,
    this.relatedPartnerId,
    this.relatedPartnerName,
    this.relationshipType,
    this.validFrom,
    this.validTo,
  });

  final String? id;
  final String? relatedPartnerId;
  final String? relatedPartnerName;
  final String? relationshipType;
  final DateTime? validFrom;
  final DateTime? validTo;

  factory PartnerRelationshipModel.fromJson(Map<String, dynamic> json) => PartnerRelationshipModel(
        id: json['id']?.toString(),
        relatedPartnerId: json['related_partner']?.toString(),
        relatedPartnerName: json['related_partner_name']?.toString(),
        relationshipType: json['relationship_type']?.toString(),
        validFrom: parseDate(json['valid_from']),
        validTo: parseDate(json['valid_to']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'related_partner': relatedPartnerId,
        'relationship_type': relationshipType,
        'valid_from': dateToJson(validFrom),
        'valid_to': dateToJson(validTo),
      };

  PartnerRelationshipModel copyWith({
    String? id,
    String? relatedPartnerId,
    String? relatedPartnerName,
    String? relationshipType,
    DateTime? validFrom,
    DateTime? validTo,
  }) =>
      PartnerRelationshipModel(
        id: id ?? this.id,
        relatedPartnerId: relatedPartnerId ?? this.relatedPartnerId,
        relatedPartnerName: relatedPartnerName ?? this.relatedPartnerName,
        relationshipType: relationshipType ?? this.relationshipType,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
      );
}
