/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/providers/supplier_form_provider.dart
 *
 * Purpose:
 *   Riverpod controller/provider for Supplier-specific onboarding fields.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier payment, bank, purchasing, and accounting defaults stay outside PartnerBasicInformation.
 *   - SupplierFormNotifier owns Supplier state and validation only.
 *   - API calls must go through Repository and API Service.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/repositories/supplier_repository.dart';
import '../state/supplier_form_state.dart';

final supplierRepositoryProvider = Provider<SupplierRepository>((ref) {
  return const SupplierRepository();
});

final supplierFormProvider =
    StateNotifierProvider<SupplierFormNotifier, SupplierFormState>((ref) {
      return SupplierFormNotifier(ref.watch(supplierRepositoryProvider));
    });

class SupplierFormNotifier extends StateNotifier<SupplierFormState> {
  SupplierFormNotifier(this._repository) : super(const SupplierFormState());

  final SupplierRepository _repository;

  void initialize({String? supplierId}) {
    state = const SupplierFormState();
    // TODO: Load existing Supplier by supplierId when edit endpoint is ready.
  }

  void updateProfile({
    String? supplierCode,
    String? supplierCategory,
    String? buyerGroup,
    String? defaultPurchaseType,
    String? taxRegistrationNo,
  }) {
    state = state.copyWith(
      supplierCode: supplierCode,
      supplierCategory: supplierCategory,
      buyerGroup: buyerGroup,
      defaultPurchaseType: defaultPurchaseType,
      taxRegistrationNo: taxRegistrationNo,
      isDirty: true,
    );
  }

  void updateBankInformation({
    String? bankName,
    String? bankBranch,
    String? bankAccountName,
    String? bankAccountNo,
    String? bankSwiftCode,
    String? bankCurrency,
  }) {
    state = state.copyWith(
      bankName: bankName,
      bankBranch: bankBranch,
      bankAccountName: bankAccountName,
      bankAccountNo: bankAccountNo,
      bankSwiftCode: bankSwiftCode,
      bankCurrency: bankCurrency,
      isDirty: true,
    );
  }

  void updatePaymentSettings({
    String? paymentTermCode,
    String? defaultCurrency,
    String? preferredPaymentMethod,
    String? creditLimit,
  }) {
    state = state.copyWith(
      paymentTermCode: paymentTermCode,
      defaultCurrency: defaultCurrency,
      preferredPaymentMethod: preferredPaymentMethod,
      creditLimit: creditLimit,
      isDirty: true,
    );
  }

  void updateAccountingDefaults({
    String? payableAccountCode,
    String? purchaseAccountCode,
    String? withholdingTaxCode,
    String? expenseCategoryCode,
  }) {
    state = state.copyWith(
      payableAccountCode: payableAccountCode,
      purchaseAccountCode: purchaseAccountCode,
      withholdingTaxCode: withholdingTaxCode,
      expenseCategoryCode: expenseCategoryCode,
      isDirty: true,
    );
  }

  Map<String, String> validateForSave() {
    final errors = <String, String>{};
    if (state.supplierCategory.trim().isEmpty) {
      errors['supplierCategory'] = 'Supplier Category is required.';
    }
    if (state.defaultCurrency.trim().isEmpty) {
      errors['defaultCurrency'] = 'Default Currency is required.';
    }
    if (state.paymentTermCode.trim().isEmpty) {
      errors['paymentTermCode'] = 'Payment Term is required.';
    }
    if (state.preferredPaymentMethod.trim().isEmpty) {
      errors['preferredPaymentMethod'] =
          'Preferred Payment Method is required.';
    }
    final creditLimit = state.creditLimit.trim();
    if (creditLimit.isNotEmpty && double.tryParse(creditLimit) == null) {
      errors['creditLimit'] = 'Credit Limit must be a valid number.';
    }
    if (state.bankAccountNo.trim().isNotEmpty &&
        state.bankAccountName.trim().isEmpty) {
      errors['bankAccountName'] =
          'Bank Account Name is required when Account No. is entered.';
    }
    state = state.copyWith(validationErrors: errors);
    return errors;
  }

  void saveDraft() {
    state = state.copyWith(
      supplierStatus: 'DRAFT',
      isDirty: false,
      validationErrors: const <String, String>{},
    );
  }

  Future<bool> saveSupplier(Map<String, dynamic> partnerRequest) async {
    final errors = validateForSave();
    if (errors.isNotEmpty) {
      return false;
    }

    state = state.copyWith(saving: true);
    try {
      final result = await _repository.onboardSupplier(<String, dynamic>{
        'partner_basic_information': partnerRequest,
        'supplier_profile': state.toJson(),
      });
      state = state.copyWith(
        supplierCode: result['supplier_code']?.toString() ?? state.supplierCode,
        supplierStatus: result['status']?.toString() ?? state.supplierStatus,
        saving: false,
        isDirty: false,
      );
      return true;
    } catch (error) {
      state = state.copyWith(
        saving: false,
        validationErrors: {'save': error.toString()},
      );
      return false;
    }
  }
}
