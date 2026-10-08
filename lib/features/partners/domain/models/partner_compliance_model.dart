/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_compliance_model.dart
 Purpose      : *   Models compliance screening fields for partner master data.
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

class PartnerComplianceModel {
  const PartnerComplianceModel({
    this.id,
    this.riskLevel,
    this.screeningStatus,
    this.lastScreenedDate,
    this.notes,
  });

  final String? id;
  final String? riskLevel;
  final String? screeningStatus;
  final DateTime? lastScreenedDate;
  final String? notes;

  factory PartnerComplianceModel.fromJson(Map<String, dynamic> json) => PartnerComplianceModel(
        id: json['id']?.toString(),
        riskLevel: json['risk_level']?.toString(),
        screeningStatus: json['screening_status']?.toString(),
        lastScreenedDate: parseDate(json['last_screened_date']),
        notes: json['notes']?.toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'risk_level': riskLevel,
        'screening_status': screeningStatus,
        'last_screened_date': dateToJson(lastScreenedDate),
        'notes': notes,
      };

  PartnerComplianceModel copyWith({
    String? id,
    String? riskLevel,
    String? screeningStatus,
    DateTime? lastScreenedDate,
    String? notes,
  }) =>
      PartnerComplianceModel(
        id: id ?? this.id,
        riskLevel: riskLevel ?? this.riskLevel,
        screeningStatus: screeningStatus ?? this.screeningStatus,
        lastScreenedDate: lastScreenedDate ?? this.lastScreenedDate,
        notes: notes ?? this.notes,
      );
}
