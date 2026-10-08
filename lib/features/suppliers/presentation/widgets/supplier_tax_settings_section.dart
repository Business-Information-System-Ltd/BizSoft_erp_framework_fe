/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/widgets/supplier_tax_settings_section.dart
 *
 * Purpose:
 *   Supplier tax default fields for Supplier onboarding.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier tax defaults stay in the Supplier extension layer.
 *   - API calls must go through Repository and API Service.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
import 'package:flutter/material.dart';

import '../../../../shared/inputs/bs_bound_fields.dart';
import '../../../../shared/layout/bs_detail_area.dart';
import '../../../../shared/layout/bs_form_row.dart';
import '../providers/supplier_form_provider.dart';
import '../state/supplier_form_state.dart';

class SupplierTaxSettingsSection extends StatelessWidget {
  const SupplierTaxSettingsSection({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SupplierFormState state;
  final SupplierFormNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return BsDetailSection(
      title: 'Tax Settings',
      subtitle: 'Tax registration and withholding defaults',
      icon: Icons.receipt_long_outlined,
      child: BsFormRow(
        children: [
          BsBoundTextField(
            label: 'Tax Registration No.',
            value: state.taxRegistrationNo,
            onChanged: (value) =>
                notifier.updateProfile(taxRegistrationNo: value),
          ),
          BsBoundTextField(
            label: 'Withholding Tax Code',
            value: state.withholdingTaxCode,
            onChanged: (value) =>
                notifier.updateAccountingDefaults(withholdingTaxCode: value),
          ),
        ],
      ),
    );
  }
}
