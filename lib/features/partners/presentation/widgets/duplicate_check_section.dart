/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/duplicate_check_section.dart
 *
 * Purpose:
 *   Duplicate check field selection section for PartnerBasicInformation.
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

import '../../../../shared/inputs/bs_checkbox_field.dart';
import '../../../../shared/layout/bs_detail_area.dart';
import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';
import 'duplicate_check_result_panel.dart';

class DuplicateCheckSection extends StatelessWidget {
  const DuplicateCheckSection({
    super.key,
    required this.state,
    required this.notifier,
    this.onCheckDuplicate,
  });

  final PartnerBasicInformationFormState state;
  final PartnerBasicInformationFormNotifier notifier;
  final VoidCallback? onCheckDuplicate;

  @override
  Widget build(BuildContext context) {
    final fields = _fieldsFor(state.partnerType);
    return BsDetailSection(
      title: 'Duplicate Check',
      initiallyExpanded: false,
      actions: [
        OutlinedButton.icon(
          onPressed: state.loading ? null : onCheckDuplicate,
          icon: const Icon(Icons.search, size: 18),
          label: const Text('Check Duplicate'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 4,
            children: [
              for (final field in fields)
                SizedBox(
                  width: 220,
                  child: BsCheckboxField(
                    label: field,
                    value: state.duplicateCheckFields.contains(field),
                    onChanged: (value) =>
                        notifier.updateDuplicateField(field, value),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          DuplicateCheckResultPanel(state: state, notifier: notifier),
        ],
      ),
    );
  }

  List<String> _fieldsFor(String partnerType) {
    return partnerType == 'NATURAL_PERSON'
        ? const [
            'Name',
            'Date of Birth',
            'Father Name',
            'Phone No.',
            'NRC No.',
            'Passport No.',
            'Identity No.',
            'Email',
          ]
        : const [
            'Display Name',
            'Registration No.',
            'Tax Identification No.',
            'Company Phone No.',
            'Identity No.',
            'Email',
          ];
  }
}
