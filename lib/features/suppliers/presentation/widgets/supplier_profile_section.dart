/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/widgets/supplier_profile_section.dart
 *
 * Purpose:
 *   Supplier-specific profile placeholder that extends PartnerBasicInformation.
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

import '../../../../shared/inputs/bs_bound_fields.dart';
import '../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../shared/layout/bs_detail_area.dart';
import '../../../../shared/layout/bs_form_row.dart';
import '../providers/supplier_form_provider.dart';
import '../state/supplier_form_state.dart';

class SupplierProfileSection extends StatelessWidget {
  const SupplierProfileSection({
    super.key,
    required this.state,
    required this.notifier,
  });

  final SupplierFormState state;
  final SupplierFormNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return BsDetailSection(
      title: 'Supplier Profile',
      subtitle: 'Supplier classification and purchasing defaults',
      icon: Icons.local_shipping_outlined,
      child: BsFormRow(
        children: [
          BsBoundTextField(
            label: 'Supplier Code',
            value: state.supplierCode,
            onChanged: (value) => notifier.updateProfile(supplierCode: value),
          ),
          BsDropdownField<String>(
            label: 'Supplier Category',
            value: state.supplierCategory,
            requiredField: true,
            errorText: state.validationErrors['supplierCategory'],
            items: const [
              DropdownMenuItem(value: 'LOCAL', child: Text('Local')),
              DropdownMenuItem(value: 'FOREIGN', child: Text('Foreign')),
              DropdownMenuItem(
                value: 'RELATED_PARTY',
                child: Text('Related Party'),
              ),
              DropdownMenuItem(value: 'ONE_TIME', child: Text('One Time')),
            ],
            onChanged: (value) =>
                notifier.updateProfile(supplierCategory: value),
          ),
          BsDropdownField<String>(
            label: 'Default Purchase Type',
            value: state.defaultPurchaseType,
            requiredField: true,
            items: const [
              DropdownMenuItem(value: 'GOODS', child: Text('Goods')),
              DropdownMenuItem(value: 'SERVICE', child: Text('Service')),
              DropdownMenuItem(value: 'ASSET', child: Text('Asset')),
              DropdownMenuItem(value: 'EXPENSE', child: Text('Expense')),
            ],
            onChanged: (value) =>
                notifier.updateProfile(defaultPurchaseType: value),
          ),
          BsBoundTextField(
            label: 'Buyer Group',
            value: state.buyerGroup,
            onChanged: (value) => notifier.updateProfile(buyerGroup: value),
          ),
        ],
      ),
    );
  }
}
