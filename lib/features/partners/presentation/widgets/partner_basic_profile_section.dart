/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/partner_basic_profile_section.dart
 *
 * Purpose:
 *   Common partner profile fields for PartnerBasicInformation.
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

import '../../../../core/widgets/responsive_form_grid.dart';
import '../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../shared/layout/bs_form_row.dart';
import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';
import 'partner_form_field_helpers.dart';

class PartnerBasicProfileSection extends StatelessWidget {
  const PartnerBasicProfileSection({
    super.key,
    required this.state,
    required this.notifier,
    this.readOnly = false,
  });

  final PartnerBasicInformationFormState state;
  final PartnerBasicInformationFormNotifier notifier;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return BsFormRow(
      children: [
        BsDropdownField<String>(
          label: 'Partner Type',
          value: state.partnerType.isEmpty ? null : state.partnerType,
          requiredField: true,
          errorText: state.validationErrors['partnerType'],
          onChanged: readOnly || !state.context.isPartnerTypeEditable
              ? null
              : notifier.updatePartnerType,
          items: const [
            DropdownMenuItem(
              value: 'NATURAL_PERSON',
              child: Text('Natural Person'),
            ),
            DropdownMenuItem(
              value: 'LEGAL_PERSON',
              child: Text('Legal Person'),
            ),
            DropdownMenuItem(
              value: 'GOVERNMENT_BODY',
              child: Text('Government Body'),
            ),
            DropdownMenuItem(value: 'OTHER', child: Text('Other')),
          ],
        ),
        PartnerBoundTextField(
          label: 'Partner Code',
          value: state.partnerCode,
          enabled: !readOnly,
          helperText: 'Leave blank for auto code',
          onChanged: (value) =>
              notifier.updatePartnerBasicProfile(partnerCode: value),
        ),
        PartnerBoundTextField(
          label: 'Short Name',
          value: state.shortName,
          enabled: !readOnly,
          onChanged: (value) =>
              notifier.updatePartnerBasicProfile(shortName: value),
        ),
        ResponsiveFormGridSpan(
          columns: 2,
          child: PartnerBoundTextField(
            label: 'Display Name',
            value: state.displayName,
            requiredField: true,
            errorText: state.validationErrors['displayName'],
            enabled: !readOnly,
            onChanged: (value) =>
                notifier.updatePartnerBasicProfile(displayName: value),
          ),
        ),
        PartnerBoundTextField(
          label: 'Country',
          value: state.country,
          enabled: !readOnly,
          onChanged: (value) =>
              notifier.updatePartnerBasicProfile(country: value),
        ),
      ],
    );
  }
}
