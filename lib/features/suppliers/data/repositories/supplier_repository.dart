/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/suppliers/data/repositories/supplier_repository.dart
 *
 * Purpose:
 *   Supplier onboarding repository placeholder.
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
class SupplierRepository {
  const SupplierRepository();

  Future<Map<String, dynamic>> onboardSupplier(
    Map<String, dynamic> request,
  ) async {
    // TODO: POST /api/suppliers/onboard/ through SupplierApiService when the
    // backend Supplier onboarding endpoint is available.
    final supplier = Map<String, dynamic>.from(
      request['supplier_profile'] as Map<String, dynamic>? ??
          const <String, dynamic>{},
    );
    return <String, dynamic>{
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'supplier_code':
          supplier['supplier_code'] ??
          'SUP-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      'status': 'DRAFT',
    };
  }
}
