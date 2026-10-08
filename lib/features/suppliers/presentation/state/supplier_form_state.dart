/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/presentation/state/supplier_form_state.dart
 *
 * Purpose:
 *   Supplier-specific form state for Supplier onboarding screens.
 *
 * Architectural Notes:
 *   - PartnerBasicInformation manages common business partner identity/profile only.
 *   - Supplier, Customer, Employee, Doctor, Patient, Bank, and other profiles extend Partner.
 *   - Supplier payment, bank, purchasing, and accounting defaults stay outside PartnerBasicInformation.
 *   - API calls must go through Repository and API Service.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
class SupplierFormState {
  const SupplierFormState({
    this.supplierCode = '',
    this.supplierCategory = 'LOCAL',
    this.supplierStatus = 'DRAFT',
    this.buyerGroup = '',
    this.defaultPurchaseType = 'GOODS',
    this.taxRegistrationNo = '',
    this.bankName = '',
    this.bankBranch = '',
    this.bankAccountName = '',
    this.bankAccountNo = '',
    this.bankSwiftCode = '',
    this.bankCurrency = 'MMK',
    this.paymentTermCode = 'NET_30',
    this.defaultCurrency = 'MMK',
    this.preferredPaymentMethod = 'BANK_TRANSFER',
    this.creditLimit = '',
    this.payableAccountCode = '',
    this.purchaseAccountCode = '',
    this.withholdingTaxCode = '',
    this.expenseCategoryCode = '',
    this.validationErrors = const <String, String>{},
    this.isDirty = false,
    this.saving = false,
  });

  final String supplierCode;
  final String supplierCategory;
  final String supplierStatus;
  final String buyerGroup;
  final String defaultPurchaseType;
  final String taxRegistrationNo;
  final String bankName;
  final String bankBranch;
  final String bankAccountName;
  final String bankAccountNo;
  final String bankSwiftCode;
  final String bankCurrency;
  final String paymentTermCode;
  final String defaultCurrency;
  final String preferredPaymentMethod;
  final String creditLimit;
  final String payableAccountCode;
  final String purchaseAccountCode;
  final String withholdingTaxCode;
  final String expenseCategoryCode;
  final Map<String, String> validationErrors;
  final bool isDirty;
  final bool saving;

  SupplierFormState copyWith({
    String? supplierCode,
    String? supplierCategory,
    String? supplierStatus,
    String? buyerGroup,
    String? defaultPurchaseType,
    String? taxRegistrationNo,
    String? bankName,
    String? bankBranch,
    String? bankAccountName,
    String? bankAccountNo,
    String? bankSwiftCode,
    String? bankCurrency,
    String? paymentTermCode,
    String? defaultCurrency,
    String? preferredPaymentMethod,
    String? creditLimit,
    String? payableAccountCode,
    String? purchaseAccountCode,
    String? withholdingTaxCode,
    String? expenseCategoryCode,
    Map<String, String>? validationErrors,
    bool? isDirty,
    bool? saving,
  }) {
    return SupplierFormState(
      supplierCode: supplierCode ?? this.supplierCode,
      supplierCategory: supplierCategory ?? this.supplierCategory,
      supplierStatus: supplierStatus ?? this.supplierStatus,
      buyerGroup: buyerGroup ?? this.buyerGroup,
      defaultPurchaseType: defaultPurchaseType ?? this.defaultPurchaseType,
      taxRegistrationNo: taxRegistrationNo ?? this.taxRegistrationNo,
      bankName: bankName ?? this.bankName,
      bankBranch: bankBranch ?? this.bankBranch,
      bankAccountName: bankAccountName ?? this.bankAccountName,
      bankAccountNo: bankAccountNo ?? this.bankAccountNo,
      bankSwiftCode: bankSwiftCode ?? this.bankSwiftCode,
      bankCurrency: bankCurrency ?? this.bankCurrency,
      paymentTermCode: paymentTermCode ?? this.paymentTermCode,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      preferredPaymentMethod:
          preferredPaymentMethod ?? this.preferredPaymentMethod,
      creditLimit: creditLimit ?? this.creditLimit,
      payableAccountCode: payableAccountCode ?? this.payableAccountCode,
      purchaseAccountCode: purchaseAccountCode ?? this.purchaseAccountCode,
      withholdingTaxCode: withholdingTaxCode ?? this.withholdingTaxCode,
      expenseCategoryCode: expenseCategoryCode ?? this.expenseCategoryCode,
      validationErrors: validationErrors ?? this.validationErrors,
      isDirty: isDirty ?? this.isDirty,
      saving: saving ?? this.saving,
    );
  }

  Map<String, dynamic> toJson() => {
    'supplier_code': supplierCode.trim().isEmpty ? null : supplierCode.trim(),
    'supplier_category': supplierCategory,
    'supplier_status': supplierStatus,
    'buyer_group': buyerGroup.trim().isEmpty ? null : buyerGroup.trim(),
    'default_purchase_type': defaultPurchaseType,
    'tax_registration_no': taxRegistrationNo.trim().isEmpty
        ? null
        : taxRegistrationNo.trim(),
    'bank_information': {
      'bank_name': bankName.trim().isEmpty ? null : bankName.trim(),
      'bank_branch': bankBranch.trim().isEmpty ? null : bankBranch.trim(),
      'bank_account_name': bankAccountName.trim().isEmpty
          ? null
          : bankAccountName.trim(),
      'bank_account_no': bankAccountNo.trim().isEmpty
          ? null
          : bankAccountNo.trim(),
      'bank_swift_code': bankSwiftCode.trim().isEmpty
          ? null
          : bankSwiftCode.trim(),
      'bank_currency': bankCurrency,
    },
    'payment_settings': {
      'payment_term_code': paymentTermCode,
      'default_currency': defaultCurrency,
      'preferred_payment_method': preferredPaymentMethod,
      'credit_limit': creditLimit.trim().isEmpty ? null : creditLimit.trim(),
    },
    'accounting_defaults': {
      'payable_account_code': payableAccountCode.trim().isEmpty
          ? null
          : payableAccountCode.trim(),
      'purchase_account_code': purchaseAccountCode.trim().isEmpty
          ? null
          : purchaseAccountCode.trim(),
      'withholding_tax_code': withholdingTaxCode.trim().isEmpty
          ? null
          : withholdingTaxCode.trim(),
      'expense_category_code': expenseCategoryCode.trim().isEmpty
          ? null
          : expenseCategoryCode.trim(),
    },
  };
}
