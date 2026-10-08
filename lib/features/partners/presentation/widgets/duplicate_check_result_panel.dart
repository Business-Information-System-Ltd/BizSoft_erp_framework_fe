/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/duplicate_check_result_panel.dart
 *
 * Purpose:
 *   Displays backend duplicate check results for PartnerBasicInformation.
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

import '../providers/partner_basic_information_form_provider.dart';
import '../state/partner_basic_information_form_state.dart';

class DuplicateCheckResultPanel extends StatelessWidget {
  const DuplicateCheckResultPanel({
    super.key,
    required this.state,
    required this.notifier,
  });

  final PartnerBasicInformationFormState state;
  final PartnerBasicInformationFormNotifier notifier;

  @override
  Widget build(BuildContext context) {
    if (state.duplicateMatches.isEmpty) {
      return const Text('No duplicate found.');
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.duplicateMatches.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = state.duplicateMatches[index];
        return ListTile(
          dense: true,
          leading: CircleAvatar(child: Text('${item.matchPercentage}%')),
          title: Text('${item.partnerCode} - ${item.displayName}'),
          subtitle: Text(
            '${item.partnerType} | ${item.identityNo ?? '-'} | ${item.status} | ${item.matchedFields.join(', ')}',
          ),
          trailing: OutlinedButton(
            onPressed: () => notifier.selectExistingPartner(item),
            child: const Text('Use Existing Partner'),
          ),
        );
      },
    );
  }
}
