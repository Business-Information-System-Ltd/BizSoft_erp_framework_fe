/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/models/partner_contact_person_model.dart
 *
 * Purpose:
 *   Models partner contact person rows for PartnerBasicInformation.
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
class PartnerContactPersonModel {
  const PartnerContactPersonModel({
    this.id,
    required this.contactPersonName,
    this.position,
    required this.phoneNo,
    this.email,
    this.relationshipToOrganization,
    this.isPrimary = false,
  });

  final String? id;
  final String contactPersonName;
  final String? position;
  final String phoneNo;
  final String? email;
  final String? relationshipToOrganization;
  final bool isPrimary;

  PartnerContactPersonModel copyWith({bool? isPrimary}) {
    return PartnerContactPersonModel(
      id: id,
      contactPersonName: contactPersonName,
      position: position,
      phoneNo: phoneNo,
      email: email,
      relationshipToOrganization: relationshipToOrganization,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
