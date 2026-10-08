/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/widgets/supplier_accounting_defaults_section.dart
 *
 * Purpose:
 *   Supplier accounting default fields for purchasing and payable setup.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Accounting defaults stay in the Supplier extension layer.
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

class SupplierAccountingDefaultsSection extends StatelessWidget {
  const SupplierAccountingDefaultsSection({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SupplierFormState state;
  final SupplierFormNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return BsDetailSection(
      title: 'Accounting Defaults',
      subtitle: 'Default posting accounts used by purchasing and AP',
      icon: Icons.account_balance_wallet_outlined,
      child: BsFormRow(
        children: [
          BsBoundTextField(
            label: 'Payable Account',
            value: state.payableAccountCode,
            onChanged: (value) =>
                notifier.updateAccountingDefaults(payableAccountCode: value),
          ),
          BsBoundTextField(
            label: 'Purchase Account',
            value: state.purchaseAccountCode,
            onChanged: (value) =>
                notifier.updateAccountingDefaults(purchaseAccountCode: value),
          ),
          BsBoundTextField(
            label: 'Expense Category',
            value: state.expenseCategoryCode,
            onChanged: (value) =>
                notifier.updateAccountingDefaults(expenseCategoryCode: value),
          ),
        ],
      ),
    );
  }
}
