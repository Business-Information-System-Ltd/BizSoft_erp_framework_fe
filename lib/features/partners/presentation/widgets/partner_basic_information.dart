/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/partner_basic_information.dart
 *
 * Purpose:
 *   Reusable common Business Partner identity/profile component.
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
import 'package:flutter/material.dart';

import '../../../../shared/layout/bs_detail_area.dart';
import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';
import 'additional_identity_list_section.dart';
import 'contact_person_section.dart';
import 'duplicate_check_section.dart';
import 'first_identity_flat_form_section.dart';
import 'partner_address_section.dart';
import 'partner_basic_profile_section.dart';

enum PartnerBasicInformationDisplayMode { full, basicOnly, detailOnly }

class PartnerBasicInformation extends StatelessWidget {
  const PartnerBasicInformation({
    super.key,
    required this.state,
    required this.notifier,
    this.isEmbeddedMode = false,
    this.showContextInfo = true,
    this.showDuplicateCheck = true,
    this.readOnly = false,
    this.displayMode = PartnerBasicInformationDisplayMode.full,
    this.onCheckDuplicate,
  });

  final PartnerBasicInformationFormState state;
  final PartnerBasicInformationFormNotifier notifier;
  final bool isEmbeddedMode;
  final bool showContextInfo;
  final bool showDuplicateCheck;
  final bool readOnly;
  final PartnerBasicInformationDisplayMode displayMode;
  final VoidCallback? onCheckDuplicate;

  @override
  Widget build(BuildContext context) {
    return switch (displayMode) {
      PartnerBasicInformationDisplayMode.basicOnly => _buildBasicArea(),
      PartnerBasicInformationDisplayMode.detailOnly => _buildTabbedDetailArea(),
      PartnerBasicInformationDisplayMode.full => _buildFullArea(),
    };
  }

  Widget _buildBasicArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        PartnerBasicProfileSection(
          state: state,
          notifier: notifier,
          readOnly: readOnly,
        ),
      ],
    );
  }

  Widget _buildTabbedDetailArea() {
    return BsTabbedDetailArea(
      tabs: [
        BsDetailTab(
          title: 'Identity',
          child: ListView(
            children: [
              FirstIdentityFlatFormSection(
                state: state,
                notifier: notifier,
                readOnly: readOnly,
              ),
              const SizedBox(height: 10),
              AdditionalIdentityListSection(
                state: state,
                notifier: notifier,
                readOnly: readOnly,
              ),
            ],
          ),
        ),
        BsDetailTab(
          title: 'Address',
          child: PartnerAddressSection(
            state: state,
            notifier: notifier,
            readOnly: readOnly,
          ),
        ),
        BsDetailTab(
          title: 'Contact',
          child: ContactPersonSection(
            state: state,
            notifier: notifier,
            readOnly: readOnly,
          ),
        ),
        if (showDuplicateCheck)
          BsDetailTab(
            title: 'Duplicate',
            child: SingleChildScrollView(
              child: DuplicateCheckSection(
                state: state,
                notifier: notifier,
                onCheckDuplicate: onCheckDuplicate,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildFullArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBasicArea(),
        const SizedBox(height: 8),
        FirstIdentityFlatFormSection(
          state: state,
          notifier: notifier,
          readOnly: readOnly,
        ),
        const SizedBox(height: 8),
        AdditionalIdentityListSection(
          state: state,
          notifier: notifier,
          readOnly: readOnly,
        ),
        const SizedBox(height: 8),
        PartnerAddressSection(
          state: state,
          notifier: notifier,
          readOnly: readOnly,
        ),
        const SizedBox(height: 8),
        ContactPersonSection(
          state: state,
          notifier: notifier,
          readOnly: readOnly,
        ),
        if (showDuplicateCheck) ...[
          const SizedBox(height: 8),
          DuplicateCheckSection(
            state: state,
            notifier: notifier,
            onCheckDuplicate: onCheckDuplicate,
          ),
        ],
      ],
    );
  }
}
