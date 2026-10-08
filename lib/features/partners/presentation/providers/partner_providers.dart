/*
 * BizSoft ERP - Business Partner Module
 *
 * File:
 *   lib/features/partners/presentation/providers/partner_providers.dart
 *
 * Purpose:
 *   Provides shared API service and repository dependencies for Partner UI.
 *
 * Architectural Notes:
 *   - Partner providers compose common BizSoft API infrastructure.
 *   - API calls must go through Repository and API Service.
 *   - Partner screens must not call Dio or BsApiClient directly.
 *   - Backend remains the source of truth for validation, duplicate checks, role assignment, and policy decisions.
 *
 * Author:
 *   BizSoft Systems
 *
 * Created:
 *   2026-06-11
 */
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/bs_api_client_provider.dart';
import '../../data/repositories/partner_repository.dart';
import '../../data/services/partner_api_service.dart';

final partnerApiServiceProvider = Provider<PartnerApiService>((ref) {
  return PartnerApiService(ref.watch(bsApiClientProvider));
});

final partnerRepositoryProvider = Provider<PartnerRepository>((ref) {
  return PartnerRepository(ref.watch(partnerApiServiceProvider));
});
