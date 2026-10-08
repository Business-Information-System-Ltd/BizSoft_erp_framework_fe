/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/dto/create_partner_basic_information_request.dart
 *
 * Purpose:
 *   Request DTO for creating partner basic information with caller context.
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
import 'create_partner_address_request.dart';
import 'create_partner_contact_person_request.dart';
import 'create_partner_identity_document_request.dart';

class CreatePartnerBasicInformationRequest {
  const CreatePartnerBasicInformationRequest({
    this.callerProgram,
    this.entryMode,
    this.preselectedPartnerType,
    this.preselectedRole,
    this.preselectedRelationship,
    this.legalEntityId,
    this.organizationUnitId,
    this.partnerCode,
    required this.partnerType,
    required this.displayName,
    this.shortName,
    this.country = 'Myanmar',
    this.defaultLanguage = 'English',
    this.remarks,
    required this.firstIdentity,
    this.additionalIdentities = const <CreatePartnerIdentityDocumentRequest>[],
    this.addresses = const <CreatePartnerAddressRequest>[],
    this.contactPersons = const <CreatePartnerContactPersonRequest>[],
  });

  final String? callerProgram;
  final String? entryMode;
  final String? preselectedPartnerType;
  final String? preselectedRole;
  final String? preselectedRelationship;
  final String? legalEntityId;
  final String? organizationUnitId;
  final String? partnerCode;
  final String partnerType;
  final String displayName;
  final String? shortName;
  final String country;
  final String defaultLanguage;
  final String? remarks;
  final CreatePartnerIdentityDocumentRequest firstIdentity;
  final List<CreatePartnerIdentityDocumentRequest> additionalIdentities;
  final List<CreatePartnerAddressRequest> addresses;
  final List<CreatePartnerContactPersonRequest> contactPersons;

  Map<String, dynamic> toJson() => {
    'caller_program': callerProgram,
    'entry_mode': entryMode,
    'preselected_partner_type': preselectedPartnerType,
    'preselected_role': preselectedRole,
    'preselected_relationship': preselectedRelationship,
    'legal_entity_id': legalEntityId,
    'organization_unit_id': organizationUnitId,
    'partner_code': partnerCode,
    'partner_type': partnerType,
    'display_name': displayName,
    'short_name': shortName,
    'country': country,
    'default_language': defaultLanguage,
    'remarks': remarks,
    'first_identity': firstIdentity.toJson(),
    'additional_identities': additionalIdentities
        .map((item) => item.toJson())
        .toList(),
    'addresses': addresses.map((item) => item.toJson()).toList(),
    'contact_persons': contactPersons.map((item) => item.toJson()).toList(),
  };
}
