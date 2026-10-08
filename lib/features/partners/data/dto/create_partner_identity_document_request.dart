/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/dto/create_partner_identity_document_request.dart
 *
 * Purpose:
 *   Request DTO for creating partner identity document records.
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
class CreatePartnerIdentityDocumentRequest {
  const CreatePartnerIdentityDocumentRequest({
    required this.identityType,
    required this.identityNo,
    this.issuingCountry = 'Myanmar',
    this.issuingAuthority,
    this.issueDate,
    this.expiryDate,
    this.isPrimary = false,
    this.attachmentId,
    this.remarks,
  });

  final String identityType;
  final String identityNo;
  final String issuingCountry;
  final String? issuingAuthority;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final bool isPrimary;
  final String? attachmentId;
  final String? remarks;

  Map<String, dynamic> toJson() => {
    'identity_type': identityType,
    'identity_no': identityNo,
    'issuing_country': issuingCountry,
    'issuing_authority': issuingAuthority,
    'issue_date': issueDate?.toIso8601String(),
    'expiry_date': expiryDate?.toIso8601String(),
    'is_primary': isPrimary,
    'attachment_id': attachmentId,
    'remarks': remarks,
  };
}
