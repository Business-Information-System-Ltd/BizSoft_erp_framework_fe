/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/models/partner_address_model.dart
 *
 * Purpose:
 *   Models partner address rows for PartnerBasicInformation.
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
class PartnerAddressModel {
  const PartnerAddressModel({
    this.id,
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

  final String? id;
  final String addressType;
  final String country;
  final String? stateRegion;
  final String? township;
  final String? city;
  final String? streetBuilding;
  final String? postalCode;
  final String fullAddress;
  final bool isPrimary;

  PartnerAddressModel copyWith({bool? isPrimary}) {
    return PartnerAddressModel(
      id: id,
      addressType: addressType,
      country: country,
      stateRegion: stateRegion,
      township: township,
      city: city,
      streetBuilding: streetBuilding,
      postalCode: postalCode,
      fullAddress: fullAddress,
      isPrimary: isPrimary ?? this.isPrimary,
    );
  }
}
