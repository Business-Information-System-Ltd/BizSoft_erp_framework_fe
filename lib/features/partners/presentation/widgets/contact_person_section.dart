/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/contact_person_section.dart
 *
 * Purpose:
 *   Contact person section for PartnerBasicInformation.
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
import 'add_contact_person_dialog.dart';

class ContactPersonSection extends StatelessWidget {
  const ContactPersonSection({
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
      title: 'Contact Person',
      subtitle: state.isLegalPerson
          ? 'Required for legal person before Save Partner.'
          : 'Optional for this partner type.',
      actions: [
        OutlinedButton.icon(
          onPressed: readOnly
              ? null
              : () async {
                  final contact = await AddContactPersonDialog.show(context);
                  if (contact != null) {
                    notifier.addContactPerson(contact);
                  }
                },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Contact Person'),
        ),
      ],
      child: state.contactPersons.isEmpty
          ? const Center(child: Text('No contact persons added.'))
          : ListView.separated(
              itemCount: state.contactPersons.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.contactPersons[index];
                return ListTile(
                  dense: true,
                  leading: Icon(
                    item.isPrimary
                        ? Icons.person_pin_outlined
                        : Icons.person_outline,
                  ),
                  title: Text(item.contactPersonName),
                  subtitle: Text(
                    '${item.position ?? '-'} | ${item.phoneNo} | ${item.email ?? '-'}',
                  ),
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        tooltip: 'Edit',
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: readOnly
                            ? null
                            : () async {
                                final edited =
                                    await AddContactPersonDialog.show(
                                      context,
                                      initial: item,
                                    );
                                if (edited != null) {
                                  notifier.editContactPerson(index, edited);
                                }
                              },
                      ),
                      IconButton(
                        tooltip: 'Delete',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: readOnly
                            ? null
                            : () => notifier.removeContactPerson(index),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
