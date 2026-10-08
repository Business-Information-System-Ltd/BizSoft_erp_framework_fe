/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/models/partner_basic_information_model.dart
 *
 * Purpose:
 *   Holds common partner identity/profile data returned by the Partner API.
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
class PartnerBasicInformationModel {
  const PartnerBasicInformationModel({
    this.id,
    this.partnerCode,
    required this.partnerType,
    required this.displayName,
    this.shortName,
    this.status = 'DRAFT',
    this.country = 'Myanmar',
    this.defaultLanguage = 'English',
  });

  final String? id;
  final String? partnerCode;
  final String partnerType;
  final String displayName;
  final String? shortName;
  final String status;
  final String country;
  final String defaultLanguage;

  factory PartnerBasicInformationModel.fromJson(Map<String, dynamic> json) {
    return PartnerBasicInformationModel(
      id: json['id']?.toString(),
      partnerCode: json['partner_code']?.toString(),
      partnerType: json['partner_type']?.toString() ?? 'LEGAL_PERSON',
      displayName: json['display_name']?.toString() ?? '',
      shortName: json['short_name']?.toString(),
      status: json['status']?.toString() ?? 'DRAFT',
      country: json['country']?.toString() ?? 'Myanmar',
      defaultLanguage: json['default_language']?.toString() ?? 'English',
    );
  }
}
