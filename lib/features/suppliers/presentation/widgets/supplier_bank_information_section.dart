/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/widgets/supplier_bank_information_section.dart
 *
 * Purpose:
 *   Supplier bank information section for Supplier onboarding.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier bank information stays in the Supplier extension layer.
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
import '../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../shared/layout/bs_detail_area.dart';
import '../../../../shared/layout/bs_form_row.dart';
import '../providers/supplier_form_provider.dart';
import '../state/supplier_form_state.dart';

class SupplierBankInformationSection extends StatelessWidget {
  const SupplierBankInformationSection({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SupplierFormState state;
  final SupplierFormNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return BsDetailSection(
      title: 'Bank Information',
      subtitle: 'Default settlement bank account for supplier payments',
      icon: Icons.account_balance_outlined,
      child: BsFormRow(
        children: [
          BsBoundTextField(
            label: 'Bank Name',
            value: state.bankName,
            onChanged: (value) =>
                notifier.updateBankInformation(bankName: value),
          ),
          BsBoundTextField(
            label: 'Bank Branch',
            value: state.bankBranch,
            onChanged: (value) =>
                notifier.updateBankInformation(bankBranch: value),
          ),
          BsBoundTextField(
            label: 'Account Name',
            value: state.bankAccountName,
            errorText: state.validationErrors['bankAccountName'],
            onChanged: (value) =>
                notifier.updateBankInformation(bankAccountName: value),
          ),
          BsBoundTextField(
            label: 'Account No.',
            value: state.bankAccountNo,
            onChanged: (value) =>
                notifier.updateBankInformation(bankAccountNo: value),
          ),
          BsBoundTextField(
            label: 'SWIFT / Routing Code',
            value: state.bankSwiftCode,
            onChanged: (value) =>
                notifier.updateBankInformation(bankSwiftCode: value),
          ),
          BsDropdownField<String>(
            label: 'Bank Currency',
            value: state.bankCurrency,
            requiredField: true,
            items: const [
              DropdownMenuItem(value: 'MMK', child: Text('MMK')),
              DropdownMenuItem(value: 'USD', child: Text('USD')),
              DropdownMenuItem(value: 'EUR', child: Text('EUR')),
              DropdownMenuItem(value: 'SGD', child: Text('SGD')),
              DropdownMenuItem(value: 'THB', child: Text('THB')),
              DropdownMenuItem(value: 'CNY', child: Text('CNY')),
            ],
            onChanged: (value) =>
                notifier.updateBankInformation(bankCurrency: value),
          ),
        ],
      ),
    );
  }
}
