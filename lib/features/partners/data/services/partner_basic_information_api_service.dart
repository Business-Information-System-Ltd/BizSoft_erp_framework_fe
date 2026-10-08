/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/data/services/partner_basic_information_api_service.dart
 *
 * Purpose:
 *   Calls Partner Basic Information backend APIs through BsApiClient.
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
import '../../../../core/api/bs_api_client.dart';
import '../dto/check_partner_duplicate_request.dart';
import '../dto/create_partner_basic_information_request.dart';
import '../models/duplicate_partner_match_model.dart';
import '../models/partner_basic_information_model.dart';

class PartnerBasicInformationApiService {
  const PartnerBasicInformationApiService(this._client);

  final BsApiClient _client;

  static const bool _mockApi = bool.fromEnvironment(
    'PARTNER_BASIC_MOCK_API',
    defaultValue: true,
  );

  Future<List<DuplicatePartnerMatchModel>> checkDuplicate(
    CheckPartnerDuplicateRequest request,
  ) async {
    if (_mockApi) {
      final identity = request.primaryIdentityNo ?? '';
      if (request.displayName?.toLowerCase().contains('demo') ?? false) {
        return [
          DuplicatePartnerMatchModel(
            partnerId: 'P-1001',
            partnerCode: 'BP-1001',
            displayName: 'Demo Trading Co., Ltd.',
            partnerType: request.partnerType,
            matchPercentage: 86,
            matchedFields: [
              'Display Name',
              if (identity.isNotEmpty) 'Identity No.',
            ],
            phoneNo: request.phoneNo,
            identityNo: identity,
            status: 'ACTIVE',
          ),
        ];
      }
      return const <DuplicatePartnerMatchModel>[];
    }

    final response = await _client.post(
      '/api/partners/check-duplicate/',
      data: request.toJson(),
    );
    final rawItems = response is List ? response : response['results'];
    if (rawItems is! List) {
      return const <DuplicatePartnerMatchModel>[];
    }
    return rawItems
        .whereType<Map>()
        .map(
          (item) => DuplicatePartnerMatchModel.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  Future<PartnerBasicInformationModel> createPartnerBasicInformation(
    CreatePartnerBasicInformationRequest request,
  ) async {
    if (_mockApi) {
      return PartnerBasicInformationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        partnerCode: request.partnerCode?.trim().isNotEmpty == true
            ? request.partnerCode
            : 'BP-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        partnerType: request.partnerType,
        displayName: request.displayName,
        shortName: request.shortName,
        status: 'DRAFT',
        country: request.country,
        defaultLanguage: request.defaultLanguage,
      );
    }

    final response = await _client.post(
      '/api/partners/create-with-context/',
      data: request.toJson(),
    );
    return PartnerBasicInformationModel.fromJson(
      Map<String, dynamic>.from(response as Map),
    );
  }
}
