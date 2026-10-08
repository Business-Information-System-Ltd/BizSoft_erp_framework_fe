/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/repositories/partner_basic_information_repository.dart
 *
 * Purpose:
 *   Repository facade for Partner Basic Information use cases.
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
import '../dto/check_partner_duplicate_request.dart';
import '../dto/create_partner_basic_information_request.dart';
import '../models/duplicate_partner_match_model.dart';
import '../models/partner_basic_information_model.dart';
import '../services/partner_basic_information_api_service.dart';

class PartnerBasicInformationRepository {
  const PartnerBasicInformationRepository(this._service);

  final PartnerBasicInformationApiService _service;

  Future<List<DuplicatePartnerMatchModel>> checkDuplicate(
    CheckPartnerDuplicateRequest request,
  ) {
    return _service.checkDuplicate(request);
  }

  Future<PartnerBasicInformationModel> createPartnerBasicInformation(
    CreatePartnerBasicInformationRequest request,
  ) {
    return _service.createPartnerBasicInformation(request);
  }
}
