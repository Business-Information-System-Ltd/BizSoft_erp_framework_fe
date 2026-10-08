/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/dto/create_partner_contact_person_request.dart
 *
 * Purpose:
 *   Request DTO for creating partner contact person records.
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
class CreatePartnerContactPersonRequest {
  const CreatePartnerContactPersonRequest({
    required this.contactPersonName,
    this.position,
    required this.phoneNo,
    this.email,
    this.relationshipToOrganization,
    this.isPrimary = false,
  });

  final String contactPersonName;
  final String? position;
  final String phoneNo;
  final String? email;
  final String? relationshipToOrganization;
  final bool isPrimary;

  Map<String, dynamic> toJson() => {
    'contact_person_name': contactPersonName,
    'position': position,
    'phone_no': phoneNo,
    'email': email,
    'relationship_to_organization': relationshipToOrganization,
    'is_primary': isPrimary,
  };
}
