/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/partner_type_selection_section.dart
 *
 * Purpose:
 *   Partner type selection for common PartnerBasicInformation.
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

import '../../../../shared/inputs/bs_dropdown_field.dart';
import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';

class PartnerTypeSelectionSection extends StatelessWidget {
  const PartnerTypeSelectionSection({
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
    return SizedBox(
      width: 320,
      child: BsDropdownField<String>(
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
          DropdownMenuItem(value: 'LEGAL_PERSON', child: Text('Legal Person')),
          DropdownMenuItem(
            value: 'GOVERNMENT_BODY',
            child: Text('Government Body'),
          ),
          DropdownMenuItem(value: 'OTHER', child: Text('Other')),
        ],
      ),
    );
  }
}
