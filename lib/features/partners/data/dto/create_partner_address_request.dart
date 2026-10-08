/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/dto/create_partner_address_request.dart
 *
 * Purpose:
 *   Request DTO for creating partner address records.
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
class CreatePartnerAddressRequest {
  const CreatePartnerAddressRequest({
    required this.addressType,
    this.country = 'Myanmar',
    this.stateRegion,
    this.township,
    this.city,
    this.streetBuilding,
    this.postalCode,
    required this.fullAddress,
    this.isPrimary = false,
  });

  final String addressType;
  final String country;
  final String? stateRegion;
  final String? township;
  final String? city;
  final String? streetBuilding;
  final String? postalCode;
  final String fullAddress;
  final bool isPrimary;

  Map<String, dynamic> toJson() => {
    'address_type': addressType,
    'country': country,
    'state_region': stateRegion,
    'township': township,
    'city': city,
    'street_building': streetBuilding,
    'postal_code': postalCode,
    'full_address': fullAddress,
    'is_primary': isPrimary,
  };
}
