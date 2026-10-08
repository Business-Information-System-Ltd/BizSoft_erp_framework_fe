/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/state/partner_identity_document_form_state.dart
 *
 * Purpose:
 *   Form state for partner identity document input.
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
class PartnerIdentityDocumentFormState {
  const PartnerIdentityDocumentFormState({
    this.identityType = '',
    this.identityNo = '',
    this.issuingCountry = 'Myanmar',
    this.issuingAuthority = '',
    this.issueDate,
    this.expiryDate,
    this.isPrimary = true,
    this.attachmentId = '',
    this.remarks = '',
  });

  final String identityType;
  final String identityNo;
  final String issuingCountry;
  final String issuingAuthority;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final bool isPrimary;
  final String attachmentId;
  final String remarks;

  bool get hasValue =>
      identityType.trim().isNotEmpty || identityNo.trim().isNotEmpty;

  PartnerIdentityDocumentFormState copyWith({
    String? identityType,
    String? identityNo,
    String? issuingCountry,
    String? issuingAuthority,
    DateTime? issueDate,
    bool clearIssueDate = false,
    DateTime? expiryDate,
    bool clearExpiryDate = false,
    bool? isPrimary,
    String? attachmentId,
    String? remarks,
  }) {
    return PartnerIdentityDocumentFormState(
      identityType: identityType ?? this.identityType,
      identityNo: identityNo ?? this.identityNo,
      issuingCountry: issuingCountry ?? this.issuingCountry,
      issuingAuthority: issuingAuthority ?? this.issuingAuthority,
      issueDate: clearIssueDate ? null : issueDate ?? this.issueDate,
      expiryDate: clearExpiryDate ? null : expiryDate ?? this.expiryDate,
      isPrimary: isPrimary ?? this.isPrimary,
      attachmentId: attachmentId ?? this.attachmentId,
      remarks: remarks ?? this.remarks,
    );
  }
}
