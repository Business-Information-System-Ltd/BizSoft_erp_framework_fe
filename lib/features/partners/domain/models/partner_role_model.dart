/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_role_model.dart
 Purpose      : *   Models module-neutral Partner role assignments.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import '../enums/partner_enums.dart';
import 'model_helpers.dart';

class PartnerRoleModel {
  const PartnerRoleModel({
    this.id,
    required this.roleType,
    this.validFrom,
    this.validTo,
    this.isPrimary = false,
    this.remarks,
  });

  final String? id;
  final PartnerRoleType roleType;
  final DateTime? validFrom;
  final DateTime? validTo;
  final bool isPrimary;
  final String? remarks;

  factory PartnerRoleModel.fromJson(Map<String, dynamic> json) => PartnerRoleModel(
        id: json['id']?.toString(),
        roleType: PartnerRoleTypeJson.fromJson(json['role_type']?.toString()),
        validFrom: parseDate(json['valid_from']),
        validTo: parseDate(json['valid_to']),
        isPrimary: json['is_primary'] == true,
        remarks: json['remarks']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'role_type': roleType.value,
        'valid_from': dateToJson(validFrom),
        'valid_to': dateToJson(validTo),
        'is_primary': isPrimary,
        'remarks': remarks,
      };

  PartnerRoleModel copyWith({
    String? id,
    PartnerRoleType? roleType,
    DateTime? validFrom,
    DateTime? validTo,
    bool? isPrimary,
    String? remarks,
  }) =>
      PartnerRoleModel(
        id: id ?? this.id,
        roleType: roleType ?? this.roleType,
        validFrom: validFrom ?? this.validFrom,
        validTo: validTo ?? this.validTo,
        isPrimary: isPrimary ?? this.isPrimary,
        remarks: remarks ?? this.remarks,
      );
}
