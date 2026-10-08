/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/models/duplicate_partner_match_model.dart
 *
 * Purpose:
 *   Models duplicate partner match results returned by duplicate checking.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier, Customer, Employee, Doctor, Patient, Bank, and other profiles extend Partner.
 *   - Partner role and relationship are decided by caller program or backend onboarding service.
 *   - UI must not enforce final business policy; backend is the source of truth.
 *   - API calls must go through Repository and API Service.
 *   - First identity is displayed on the main form.
 *   - Additional identities are entered through dialog, side panel, or accordion.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
class DuplicatePartnerMatchModel {
  const DuplicatePartnerMatchModel({
    required this.partnerId,
    required this.partnerCode,
    required this.displayName,
    required this.partnerType,
    required this.matchPercentage,
    this.matchedFields = const <String>[],
    this.phoneNo,
    this.identityNo,
    this.status = 'DRAFT',
  });

  final String partnerId;
  final String partnerCode;
  final String displayName;
  final String partnerType;
  final int matchPercentage;
  final List<String> matchedFields;
  final String? phoneNo;
  final String? identityNo;
  final String status;

  factory DuplicatePartnerMatchModel.fromJson(Map<String, dynamic> json) {
    final rawFields = json['matched_fields'];
    return DuplicatePartnerMatchModel(
      partnerId: json['partner_id']?.toString() ?? '',
      partnerCode: json['partner_code']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? '',
      partnerType: json['partner_type']?.toString() ?? '',
      matchPercentage:
          int.tryParse(json['match_percentage']?.toString() ?? '') ?? 0,
      matchedFields: rawFields is List
          ? rawFields.map((item) => '$item').toList()
          : const <String>[],
      phoneNo: json['phone_no']?.toString(),
      identityNo: json['identity_no']?.toString(),
      status: json['status']?.toString() ?? 'DRAFT',
    );
  }
}
