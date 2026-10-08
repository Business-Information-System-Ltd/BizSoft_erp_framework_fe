/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/widgets/supplier_payment_settings_section.dart
 *
 * Purpose:
 *   Supplier payment term and default currency section.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Payment terms, default currency, and payment method are Supplier extension fields.
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

class SupplierPaymentSettingsSection extends StatelessWidget {
  const SupplierPaymentSettingsSection({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SupplierFormState state;
  final SupplierFormNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return BsDetailSection(
      title: 'Payment Settings',
      subtitle: 'Default currency, payment term, method, and credit limit',
      icon: Icons.payments_outlined,
      child: BsFormRow(
        children: [
          BsDropdownField<String>(
            label: 'Payment Term',
            value: state.paymentTermCode,
            requiredField: true,
            errorText: state.validationErrors['paymentTermCode'],
            items: const [
              DropdownMenuItem(
                value: 'DUE_ON_RECEIPT',
                child: Text('Due on Receipt'),
              ),
              DropdownMenuItem(value: 'NET_7', child: Text('Net 7 Days')),
              DropdownMenuItem(value: 'NET_15', child: Text('Net 15 Days')),
              DropdownMenuItem(value: 'NET_30', child: Text('Net 30 Days')),
              DropdownMenuItem(value: 'NET_60', child: Text('Net 60 Days')),
            ],
            onChanged: (value) =>
                notifier.updatePaymentSettings(paymentTermCode: value),
          ),
          BsDropdownField<String>(
            label: 'Default Currency',
            value: state.defaultCurrency,
            requiredField: true,
            errorText: state.validationErrors['defaultCurrency'],
            items: const [
              DropdownMenuItem(value: 'MMK', child: Text('MMK')),
              DropdownMenuItem(value: 'USD', child: Text('USD')),
              DropdownMenuItem(value: 'EUR', child: Text('EUR')),
              DropdownMenuItem(value: 'SGD', child: Text('SGD')),
              DropdownMenuItem(value: 'THB', child: Text('THB')),
              DropdownMenuItem(value: 'CNY', child: Text('CNY')),
            ],
            onChanged: (value) =>
                notifier.updatePaymentSettings(defaultCurrency: value),
          ),
          BsDropdownField<String>(
            label: 'Payment Method',
            value: state.preferredPaymentMethod,
            requiredField: true,
            errorText: state.validationErrors['preferredPaymentMethod'],
            items: const [
              DropdownMenuItem(
                value: 'BANK_TRANSFER',
                child: Text('Bank Transfer'),
              ),
              DropdownMenuItem(value: 'CASH', child: Text('Cash')),
              DropdownMenuItem(value: 'CHEQUE', child: Text('Cheque')),
              DropdownMenuItem(
                value: 'MOBILE_PAYMENT',
                child: Text('Mobile Payment'),
              ),
              DropdownMenuItem(
                value: 'LETTER_OF_CREDIT',
                child: Text('Letter of Credit'),
              ),
            ],
            onChanged: (value) =>
                notifier.updatePaymentSettings(preferredPaymentMethod: value),
          ),
          BsBoundTextField(
            label: 'Credit Limit',
            value: state.creditLimit,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            errorText: state.validationErrors['creditLimit'],
            onChanged: (value) =>
                notifier.updatePaymentSettings(creditLimit: value),
          ),
        ],
      ),
    );
  }
}
