/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/providers/partner_basic_information_form_provider.dart
 *
 * Purpose:
 *   Riverpod notifier/provider for PartnerBasicInformation forms.
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/providers/bs_api_client_provider.dart';
import '../../data/dto/check_partner_duplicate_request.dart';
import '../../data/dto/create_partner_address_request.dart';
import '../../data/dto/create_partner_basic_information_request.dart';
import '../../data/dto/create_partner_contact_person_request.dart';
import '../../data/dto/create_partner_identity_document_request.dart';
import '../../data/models/duplicate_partner_match_model.dart';
import '../../data/models/partner_address_model.dart';
import '../../data/models/partner_contact_person_model.dart';
import '../../data/models/partner_identity_document_model.dart';
import '../../data/repositories/partner_basic_information_repository.dart';
import '../../data/services/partner_basic_information_api_service.dart';
import '../state/partner_basic_information_form_state.dart';
import '../state/partner_identity_document_form_state.dart';

final partnerBasicInformationApiServiceProvider =
    Provider<PartnerBasicInformationApiService>((ref) {
      return PartnerBasicInformationApiService(ref.watch(bsApiClientProvider));
    });

final partnerBasicInformationRepositoryProvider =
    Provider<PartnerBasicInformationRepository>((ref) {
      return PartnerBasicInformationRepository(
        ref.watch(partnerBasicInformationApiServiceProvider),
      );
    });

final partnerBasicInformationFormProvider =
    StateNotifierProvider<
      PartnerBasicInformationFormNotifier,
      PartnerBasicInformationFormState
    >((ref) {
      return PartnerBasicInformationFormNotifier(
        ref.watch(partnerBasicInformationRepositoryProvider),
      );
    });

class PartnerBasicInformationFormNotifier
    extends StateNotifier<PartnerBasicInformationFormState> {
  PartnerBasicInformationFormNotifier(this._repository)
    : super(const PartnerBasicInformationFormState());

  final PartnerBasicInformationRepository _repository;

  void initializeWithContext(PartnerBasicInformationCallerContext context) {
    final partnerType = context.preselectedPartnerType ?? state.partnerType;
    state = state.copyWith(
      context: context,
      partnerType: partnerType,
      duplicateCheckFields: _defaultDuplicateFields(partnerType),
      isDirty: false,
    );
  }

  void updatePartnerType(String? value) {
    if (value == null || value == state.partnerType) {
      return;
    }
    state = state.copyWith(
      partnerType: value,
      firstIdentity: state.firstIdentity.copyWith(identityType: ''),
      duplicateCheckFields: _defaultDuplicateFields(value),
      isDirty: true,
      validationErrors: const <String, String>{},
    );
  }

  void updatePartnerBasicProfile({
    String? partnerCode,
    String? displayName,
    String? shortName,
    String? country,
    String? defaultLanguage,
    String? remarks,
  }) {
    state = state.copyWith(
      partnerCode: partnerCode,
      displayName: displayName,
      shortName: shortName,
      country: country,
      defaultLanguage: defaultLanguage,
      remarks: remarks,
      isDirty: true,
    );
  }

  void updateFirstIdentity(PartnerIdentityDocumentFormState identity) {
    state = state.copyWith(firstIdentity: identity, isDirty: true);
  }

  void addAdditionalIdentity(PartnerIdentityDocumentModel identity) {
    final identities = identity.isPrimary
        ? state.additionalIdentities
              .map((item) => item.copyWith(isPrimary: false))
              .toList()
        : List<PartnerIdentityDocumentModel>.from(state.additionalIdentities);
    state = state.copyWith(
      firstIdentity: identity.isPrimary
          ? state.firstIdentity.copyWith(isPrimary: false)
          : state.firstIdentity,
      additionalIdentities: [...identities, identity],
      isDirty: true,
    );
  }

  void editAdditionalIdentity(
    int index,
    PartnerIdentityDocumentModel identity,
  ) {
    final identities = List<PartnerIdentityDocumentModel>.from(
      state.additionalIdentities,
    );
    if (index < 0 || index >= identities.length) {
      return;
    }
    if (identity.isPrimary) {
      for (var i = 0; i < identities.length; i++) {
        identities[i] = identities[i].copyWith(isPrimary: false);
      }
    }
    identities[index] = identity;
    state = state.copyWith(
      firstIdentity: identity.isPrimary
          ? state.firstIdentity.copyWith(isPrimary: false)
          : state.firstIdentity,
      additionalIdentities: identities,
      isDirty: true,
    );
  }

  void removeAdditionalIdentity(int index) {
    final identities = List<PartnerIdentityDocumentModel>.from(
      state.additionalIdentities,
    );
    if (index < 0 || index >= identities.length) {
      return;
    }
    identities.removeAt(index);
    state = state.copyWith(additionalIdentities: identities, isDirty: true);
  }

  void addAddress(PartnerAddressModel address) {
    final addresses = address.isPrimary
        ? state.addresses
              .map((item) => item.copyWith(isPrimary: false))
              .toList()
        : List<PartnerAddressModel>.from(state.addresses);
    state = state.copyWith(addresses: [...addresses, address], isDirty: true);
  }

  void editAddress(int index, PartnerAddressModel address) {
    final addresses = List<PartnerAddressModel>.from(state.addresses);
    if (index < 0 || index >= addresses.length) {
      return;
    }
    if (address.isPrimary) {
      for (var i = 0; i < addresses.length; i++) {
        addresses[i] = addresses[i].copyWith(isPrimary: false);
      }
    }
    addresses[index] = address;
    state = state.copyWith(addresses: addresses, isDirty: true);
  }

  void removeAddress(int index) {
    final addresses = List<PartnerAddressModel>.from(state.addresses);
    if (index < 0 || index >= addresses.length) {
      return;
    }
    addresses.removeAt(index);
    state = state.copyWith(addresses: addresses, isDirty: true);
  }

  void addContactPerson(PartnerContactPersonModel contact) {
    final contacts = contact.isPrimary
        ? state.contactPersons
              .map((item) => item.copyWith(isPrimary: false))
              .toList()
        : List<PartnerContactPersonModel>.from(state.contactPersons);
    state = state.copyWith(
      contactPersons: [...contacts, contact],
      isDirty: true,
    );
  }

  void editContactPerson(int index, PartnerContactPersonModel contact) {
    final contacts = List<PartnerContactPersonModel>.from(state.contactPersons);
    if (index < 0 || index >= contacts.length) {
      return;
    }
    if (contact.isPrimary) {
      for (var i = 0; i < contacts.length; i++) {
        contacts[i] = contacts[i].copyWith(isPrimary: false);
      }
    }
    contacts[index] = contact;
    state = state.copyWith(contactPersons: contacts, isDirty: true);
  }

  void removeContactPerson(int index) {
    final contacts = List<PartnerContactPersonModel>.from(state.contactPersons);
    if (index < 0 || index >= contacts.length) {
      return;
    }
    contacts.removeAt(index);
    state = state.copyWith(contactPersons: contacts, isDirty: true);
  }

  void updateDuplicateField(String field, bool selected) {
    final fields = List<String>.from(state.duplicateCheckFields);
    if (selected && !fields.contains(field)) {
      fields.add(field);
    }
    if (!selected) {
      fields.remove(field);
    }
    state = state.copyWith(duplicateCheckFields: fields, isDirty: true);
  }

  Future<List<DuplicatePartnerMatchModel>> checkDuplicate() async {
    state = state.copyWith(loading: true);
    try {
      final matches = await _repository.checkDuplicate(
        _buildDuplicateRequest(),
      );
      state = state.copyWith(loading: false, duplicateMatches: matches);
      return matches;
    } catch (error) {
      state = state.copyWith(
        loading: false,
        validationErrors: {'duplicate': error.toString()},
      );
      return const <DuplicatePartnerMatchModel>[];
    }
  }

  Map<String, String> validateForSave() {
    final errors = <String, String>{};
    if (state.partnerType.trim().isEmpty) {
      errors['partnerType'] = 'Partner Type is required.';
    }
    if (state.displayName.trim().isEmpty) {
      errors['displayName'] = 'Display Name is required.';
    }
    if (state.firstIdentity.identityType.trim().isEmpty) {
      errors['firstIdentityType'] = 'First Identity Type is required.';
    }
    if (state.firstIdentity.identityNo.trim().isEmpty) {
      errors['firstIdentityNo'] = 'First Identity No. is required.';
    }
    if (state.isLegalPerson && state.contactPersons.isEmpty) {
      errors['contactPerson'] =
          'Legal Person requires at least one contact person.';
    }
    final invalidContact = state.contactPersons.where(
      (item) =>
          item.contactPersonName.trim().isEmpty || item.phoneNo.trim().isEmpty,
    );
    if (invalidContact.isNotEmpty) {
      errors['contactPersonDetail'] =
          'Contact Person Name and Phone No. are required.';
    }
    state = state.copyWith(validationErrors: errors);
    return errors;
  }

  CreatePartnerBasicInformationRequest buildCreateRequest() {
    final firstIdentityRequest = _identityFormToRequest(state.firstIdentity);
    return CreatePartnerBasicInformationRequest(
      callerProgram: state.context.callerProgram,
      entryMode: state.context.entryMode,
      preselectedPartnerType: state.context.preselectedPartnerType,
      preselectedRole: state.context.preselectedRole,
      preselectedRelationship: state.context.preselectedRelationship,
      legalEntityId: state.context.currentLegalEntityId,
      organizationUnitId: state.context.currentOrganizationUnitId,
      partnerCode: state.partnerCode.trim().isEmpty
          ? null
          : state.partnerCode.trim(),
      partnerType: state.partnerType,
      displayName: state.displayName.trim(),
      shortName: state.shortName.trim().isEmpty ? null : state.shortName.trim(),
      country: state.country,
      defaultLanguage: state.defaultLanguage,
      remarks: state.remarks.trim().isEmpty ? null : state.remarks.trim(),
      firstIdentity: firstIdentityRequest,
      additionalIdentities: state.additionalIdentities
          .map(_identityModelToRequest)
          .toList(),
      addresses: state.addresses.map(_addressModelToRequest).toList(),
      contactPersons: state.contactPersons.map(_contactModelToRequest).toList(),
    );
  }

  Future<void> saveDraft() async {
    state = state.copyWith(isDirty: false, status: 'DRAFT');
    // TODO: Persist draft through BsFormDraftService when partner draft restore is enabled.
  }

  Future<bool> savePartner() async {
    final errors = validateForSave();
    if (errors.isNotEmpty) {
      return false;
    }
    state = state.copyWith(saving: true);
    try {
      final saved = await _repository.createPartnerBasicInformation(
        buildCreateRequest(),
      );
      state = state.copyWith(
        savedPartner: saved,
        partnerCode: saved.partnerCode ?? state.partnerCode,
        status: saved.status,
        saving: false,
        isDirty: false,
      );
      return true;
    } catch (error) {
      state = state.copyWith(
        saving: false,
        validationErrors: {'save': error.toString()},
      );
      return false;
    }
  }

  void markSavedByExtension({String? partnerCode, String status = 'DRAFT'}) {
    state = state.copyWith(
      partnerCode: partnerCode ?? state.partnerCode,
      status: status,
      isDirty: false,
      saving: false,
    );
  }

  void selectExistingPartner(DuplicatePartnerMatchModel match) {
    state = state.copyWith(selectedExistingPartner: match);
  }

  void resetForm() {
    state = const PartnerBasicInformationFormState();
  }

  CheckPartnerDuplicateRequest _buildDuplicateRequest() {
    final identityNumbers = [
      if (state.firstIdentity.identityNo.trim().isNotEmpty)
        state.firstIdentity.identityNo.trim(),
      for (final identity in state.additionalIdentities)
        if (identity.identityNo.trim().isNotEmpty) identity.identityNo.trim(),
    ];
    return CheckPartnerDuplicateRequest(
      partnerType: state.partnerType,
      fieldsToCheck: state.duplicateCheckFields,
      displayName: state.displayName,
      legalName: state.partnerType == 'LEGAL_PERSON' ? state.displayName : null,
      primaryIdentityType: state.firstIdentity.identityType,
      primaryIdentityNo: state.firstIdentity.identityNo,
      allIdentityNumbers: identityNumbers,
      callerProgram: state.context.callerProgram,
      entryMode: state.context.entryMode,
      legalEntityId: state.context.currentLegalEntityId,
    );
  }

  List<String> _defaultDuplicateFields(String partnerType) {
    return partnerType == 'NATURAL_PERSON'
        ? const [
            'Name',
            'Date of Birth',
            'Father Name',
            'Phone No.',
            'Identity No.',
          ]
        : const [
            'Display Name',
            'Registration No.',
            'Tax Identification No.',
            'Company Phone No.',
            'Identity No.',
          ];
  }

  CreatePartnerIdentityDocumentRequest _identityFormToRequest(
    PartnerIdentityDocumentFormState identity,
  ) {
    return CreatePartnerIdentityDocumentRequest(
      identityType: identity.identityType,
      identityNo: identity.identityNo,
      issuingCountry: identity.issuingCountry,
      issuingAuthority: identity.issuingAuthority.trim().isEmpty
          ? null
          : identity.issuingAuthority,
      issueDate: identity.issueDate,
      expiryDate: identity.expiryDate,
      isPrimary: identity.isPrimary,
      attachmentId: identity.attachmentId.trim().isEmpty
          ? null
          : identity.attachmentId,
      remarks: identity.remarks.trim().isEmpty ? null : identity.remarks,
    );
  }

  CreatePartnerIdentityDocumentRequest _identityModelToRequest(
    PartnerIdentityDocumentModel identity,
  ) {
    return CreatePartnerIdentityDocumentRequest(
      identityType: identity.identityType,
      identityNo: identity.identityNo,
      issuingCountry: identity.issuingCountry,
      issuingAuthority: identity.issuingAuthority,
      issueDate: identity.issueDate,
      expiryDate: identity.expiryDate,
      isPrimary: identity.isPrimary,
      attachmentId: identity.attachmentId,
      remarks: identity.remarks,
    );
  }

  CreatePartnerAddressRequest _addressModelToRequest(
    PartnerAddressModel address,
  ) {
    return CreatePartnerAddressRequest(
      addressType: address.addressType,
      country: address.country,
      stateRegion: address.stateRegion,
      township: address.township,
      city: address.city,
      streetBuilding: address.streetBuilding,
      postalCode: address.postalCode,
      fullAddress: address.fullAddress,
      isPrimary: address.isPrimary,
    );
  }

  CreatePartnerContactPersonRequest _contactModelToRequest(
    PartnerContactPersonModel contact,
  ) {
    return CreatePartnerContactPersonRequest(
      contactPersonName: contact.contactPersonName,
      position: contact.position,
      phoneNo: contact.phoneNo,
      email: contact.email,
      relationshipToOrganization: contact.relationshipToOrganization,
      isPrimary: contact.isPrimary,
    );
  }
}
