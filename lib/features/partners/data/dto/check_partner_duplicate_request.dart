/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/dto/check_partner_duplicate_request.dart
 *
 * Purpose:
 *   Request DTO for backend partner duplicate checking.
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
class CheckPartnerDuplicateRequest {
  const CheckPartnerDuplicateRequest({
    required this.partnerType,
    required this.fieldsToCheck,
    this.displayName,
    this.fullName,
    this.legalName,
    this.dateOfBirth,
    this.fatherName,
    this.phoneNo,
    this.email,
    this.primaryIdentityType,
    this.primaryIdentityNo,
    this.allIdentityNumbers = const <String>[],
    this.registrationNo,
    this.taxIdentificationNo,
    this.callerProgram,
    this.entryMode,
    this.legalEntityId,
  });

  final String partnerType;
  final List<String> fieldsToCheck;
  final String? displayName;
  final String? fullName;
  final String? legalName;
  final DateTime? dateOfBirth;
  final String? fatherName;
  final String? phoneNo;
  final String? email;
  final String? primaryIdentityType;
  final String? primaryIdentityNo;
  final List<String> allIdentityNumbers;
  final String? registrationNo;
  final String? taxIdentificationNo;
  final String? callerProgram;
  final String? entryMode;
  final String? legalEntityId;

  Map<String, dynamic> toJson() => {
    'partner_type': partnerType,
    'fields_to_check': fieldsToCheck,
    'display_name': displayName,
    'full_name': fullName,
    'legal_name': legalName,
    'date_of_birth': dateOfBirth?.toIso8601String(),
    'father_name': fatherName,
    'phone_no': phoneNo,
    'email': email,
    'primary_identity_type': primaryIdentityType,
    'primary_identity_no': primaryIdentityNo,
    'all_identity_numbers': allIdentityNumbers,
    'registration_no': registrationNo,
    'tax_identification_no': taxIdentificationNo,
    'caller_program': callerProgram,
    'entry_mode': entryMode,
    'legal_entity_id': legalEntityId,
  };
}
