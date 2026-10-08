/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/additional_identity_list_section.dart
 *
 * Purpose:
 *   Additional identity list/grid section for PartnerBasicInformation.
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
import 'add_identity_dialog.dart';

class AdditionalIdentityListSection extends StatelessWidget {
  const AdditionalIdentityListSection({
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
    return BsDetailGridSection(
      title: 'Additional Identities',
      subtitle: 'Add optional extra identity documents.',
      initiallyExpanded: false,
      actions: [
        OutlinedButton.icon(
          onPressed: readOnly
              ? null
              : () async {
                  final identity = await AddIdentityDialog.show(
                    context,
                    partnerType: state.partnerType,
                  );
                  if (identity != null) {
                    notifier.addAdditionalIdentity(identity);
                  }
                },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Identity'),
        ),
      ],
      child: state.additionalIdentities.isEmpty
          ? const Center(child: Text('No additional identities.'))
          : ListView.separated(
              itemCount: state.additionalIdentities.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.additionalIdentities[index];
                return ListTile(
                  dense: true,
                  leading: Icon(
                    item.isPrimary
                        ? Icons.verified_outlined
                        : Icons.badge_outlined,
                  ),
                  title: Text('${item.identityType} - ${item.identityNo}'),
                  subtitle: Text('${item.issuingCountry} | ${item.status}'),
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        tooltip: 'Edit',
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: readOnly
                            ? null
                            : () async {
                                final edited = await AddIdentityDialog.show(
                                  context,
                                  partnerType: state.partnerType,
                                  initial: item,
                                );
                                if (edited != null) {
                                  notifier.editAdditionalIdentity(
                                    index,
                                    edited,
                                  );
                                }
                              },
                      ),
                      IconButton(
                        tooltip: 'Delete',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: readOnly
                            ? null
                            : () => notifier.removeAdditionalIdentity(index),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
