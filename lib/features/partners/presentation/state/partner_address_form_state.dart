/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/state/partner_address_form_state.dart
 *
 * Purpose:
 *   Form state for partner address input.
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
class PartnerAddressFormState {
  const PartnerAddressFormState({
    this.addressType = 'Business',
    this.country = 'Myanmar',
    this.stateRegion = '',
    this.township = '',
    this.city = '',
    this.streetBuilding = '',
    this.postalCode = '',
    this.fullAddress = '',
    this.isPrimary = true,
  });

  final String addressType;
  final String country;
  final String stateRegion;
  final String township;
  final String city;
  final String streetBuilding;
  final String postalCode;
  final String fullAddress;
  final bool isPrimary;
}
