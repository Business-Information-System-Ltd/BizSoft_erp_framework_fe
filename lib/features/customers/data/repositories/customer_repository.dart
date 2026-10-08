/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/customers/data/repositories/customer_repository.dart
 *
 * Purpose:
 *   Customer onboarding repository placeholder.
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
class CustomerRepository {
  const CustomerRepository();

  Future<void> onboardCustomer(Map<String, dynamic> request) async {
    // TODO: POST /api/customers/onboard/ through CustomerApiService.
  }
}
