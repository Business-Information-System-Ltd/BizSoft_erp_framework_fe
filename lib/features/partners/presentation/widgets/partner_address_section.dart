/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/widgets/partner_address_section.dart
 *
 * Purpose:
 *   Address list section for PartnerBasicInformation.
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
import 'add_address_dialog.dart';

class PartnerAddressSection extends StatelessWidget {
  const PartnerAddressSection({
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
      title: 'Address',
      subtitle:
          'At least one address can be captured before activation if policy requires.',
      actions: [
        OutlinedButton.icon(
          onPressed: readOnly
              ? null
              : () async {
                  final address = await AddAddressDialog.show(context);
                  if (address != null) {
                    notifier.addAddress(address);
                  }
                },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Address'),
        ),
      ],
      child: state.addresses.isEmpty
          ? const Center(child: Text('No addresses added.'))
          : ListView.separated(
              itemCount: state.addresses.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = state.addresses[index];
                return ListTile(
                  dense: true,
                  leading: Icon(
                    item.isPrimary
                        ? Icons.home_work_outlined
                        : Icons.location_on_outlined,
                  ),
                  title: Text(
                    '${item.addressType} - ${item.city ?? item.country}',
                  ),
                  subtitle: Text(item.fullAddress),
                  trailing: Wrap(
                    spacing: 4,
                    children: [
                      IconButton(
                        tooltip: 'Edit',
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: readOnly
                            ? null
                            : () async {
                                final edited = await AddAddressDialog.show(
                                  context,
                                  initial: item,
                                );
                                if (edited != null) {
                                  notifier.editAddress(index, edited);
                                }
                              },
                      ),
                      IconButton(
                        tooltip: 'Delete',
                        icon: const Icon(Icons.delete_outline),
                        onPressed: readOnly
                            ? null
                            : () => notifier.removeAddress(index),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
