/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/state/partner_basic_information_form_state.dart
 *
 * Purpose:
 *   Main PartnerBasicInformation form state and caller context.
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
import '../../data/models/duplicate_partner_match_model.dart';
import '../../data/models/partner_address_model.dart';
import '../../data/models/partner_basic_information_model.dart';
import '../../data/models/partner_contact_person_model.dart';
import '../../data/models/partner_identity_document_model.dart';
import 'partner_identity_document_form_state.dart';

class PartnerBasicInformationCallerContext {
  const PartnerBasicInformationCallerContext({
    this.callerProgram = 'Partner Master',
    this.entryMode = 'PARTNER',
    this.preselectedPartnerType,
    this.preselectedRole,
    this.preselectedRelationship,
    this.currentLegalEntityId,
    this.currentLegalEntityName,
    this.currentOrganizationUnitId,
    this.currentOrganizationUnitName,
    this.isPartnerTypeEditable = true,
    this.isEmbeddedMode = false,
  });

  final String callerProgram;
  final String entryMode;
  final String? preselectedPartnerType;
  final String? preselectedRole;
  final String? preselectedRelationship;
  final String? currentLegalEntityId;
  final String? currentLegalEntityName;
  final String? currentOrganizationUnitId;
  final String? currentOrganizationUnitName;
  final bool isPartnerTypeEditable;
  final bool isEmbeddedMode;
}

class PartnerBasicInformationFormState {
  const PartnerBasicInformationFormState({
    this.context = const PartnerBasicInformationCallerContext(),
    this.savedPartner,
    this.partnerCode = '',
    this.partnerType = '',
    this.displayName = '',
    this.shortName = '',
    this.country = 'Myanmar',
    this.defaultLanguage = 'English',
    this.status = 'DRAFT',
    this.remarks = '',
    this.firstIdentity = const PartnerIdentityDocumentFormState(
      isPrimary: true,
    ),
    this.additionalIdentities = const <PartnerIdentityDocumentModel>[],
    this.addresses = const <PartnerAddressModel>[],
    this.contactPersons = const <PartnerContactPersonModel>[],
    this.duplicateCheckFields = const <String>[],
    this.duplicateMatches = const <DuplicatePartnerMatchModel>[],
    this.loading = false,
    this.saving = false,
    this.validationErrors = const <String, String>{},
    this.isDirty = false,
    this.selectedExistingPartner,
  });

  final PartnerBasicInformationCallerContext context;
  final PartnerBasicInformationModel? savedPartner;
  final String partnerCode;
  final String partnerType;
  final String displayName;
  final String shortName;
  final String country;
  final String defaultLanguage;
  final String status;
  final String remarks;
  final PartnerIdentityDocumentFormState firstIdentity;
  final List<PartnerIdentityDocumentModel> additionalIdentities;
  final List<PartnerAddressModel> addresses;
  final List<PartnerContactPersonModel> contactPersons;
  final List<String> duplicateCheckFields;
  final List<DuplicatePartnerMatchModel> duplicateMatches;
  final bool loading;
  final bool saving;
  final Map<String, String> validationErrors;
  final bool isDirty;
  final DuplicatePartnerMatchModel? selectedExistingPartner;

  bool get isLegalPerson => partnerType == 'LEGAL_PERSON';
  bool get hasPrimaryIdentity =>
      firstIdentity.isPrimary ||
      additionalIdentities.any((item) => item.isPrimary);

  PartnerBasicInformationFormState copyWith({
    PartnerBasicInformationCallerContext? context,
    PartnerBasicInformationModel? savedPartner,
    String? partnerCode,
    String? partnerType,
    String? displayName,
    String? shortName,
    String? country,
    String? defaultLanguage,
    String? status,
    String? remarks,
    PartnerIdentityDocumentFormState? firstIdentity,
    List<PartnerIdentityDocumentModel>? additionalIdentities,
    List<PartnerAddressModel>? addresses,
    List<PartnerContactPersonModel>? contactPersons,
    List<String>? duplicateCheckFields,
    List<DuplicatePartnerMatchModel>? duplicateMatches,
    bool? loading,
    bool? saving,
    Map<String, String>? validationErrors,
    bool? isDirty,
    DuplicatePartnerMatchModel? selectedExistingPartner,
    bool clearSelectedExistingPartner = false,
  }) {
    return PartnerBasicInformationFormState(
      context: context ?? this.context,
      savedPartner: savedPartner ?? this.savedPartner,
      partnerCode: partnerCode ?? this.partnerCode,
      partnerType: partnerType ?? this.partnerType,
      displayName: displayName ?? this.displayName,
      shortName: shortName ?? this.shortName,
      country: country ?? this.country,
      defaultLanguage: defaultLanguage ?? this.defaultLanguage,
      status: status ?? this.status,
      remarks: remarks ?? this.remarks,
      firstIdentity: firstIdentity ?? this.firstIdentity,
      additionalIdentities: additionalIdentities ?? this.additionalIdentities,
      addresses: addresses ?? this.addresses,
      contactPersons: contactPersons ?? this.contactPersons,
      duplicateCheckFields: duplicateCheckFields ?? this.duplicateCheckFields,
      duplicateMatches: duplicateMatches ?? this.duplicateMatches,
      loading: loading ?? this.loading,
      saving: saving ?? this.saving,
      validationErrors: validationErrors ?? this.validationErrors,
      isDirty: isDirty ?? this.isDirty,
      selectedExistingPartner: clearSelectedExistingPartner
          ? null
          : selectedExistingPartner ?? this.selectedExistingPartner,
    );
  }
}
