/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/models/partner_identity_document_model.dart
 *
 * Purpose:
 *   Models partner identity document rows for PartnerBasicInformation.
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
class PartnerIdentityDocumentModel {
  const PartnerIdentityDocumentModel({
    this.id,
    required this.identityType,
    required this.identityNo,
    this.issuingCountry = 'Myanmar',
    this.issuingAuthority,
    this.issueDate,
    this.expiryDate,
    this.isPrimary = false,
    this.status = 'DRAFT',
    this.attachmentId,
    this.remarks,
  });

  final String? id;
  final String identityType;
  final String identityNo;
  final String issuingCountry;
  final String? issuingAuthority;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final bool isPrimary;
  final String status;
  final String? attachmentId;
  final String? remarks;

  PartnerIdentityDocumentModel copyWith({
    String? id,
    String? identityType,
    String? identityNo,
    String? issuingCountry,
    String? issuingAuthority,
    DateTime? issueDate,
    DateTime? expiryDate,
    bool? isPrimary,
    String? status,
    String? attachmentId,
    String? remarks,
  }) {
    return PartnerIdentityDocumentModel(
      id: id ?? this.id,
      identityType: identityType ?? this.identityType,
      identityNo: identityNo ?? this.identityNo,
      issuingCountry: issuingCountry ?? this.issuingCountry,
      issuingAuthority: issuingAuthority ?? this.issuingAuthority,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      isPrimary: isPrimary ?? this.isPrimary,
      status: status ?? this.status,
      attachmentId: attachmentId ?? this.attachmentId,
      remarks: remarks ?? this.remarks,
    );
  }
}
