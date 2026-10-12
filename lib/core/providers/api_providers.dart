import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/bs_api_client.dart';
import 'bs_dio_provider.dart';

import '../../modules/far/far_asset/data/service/far_asset_api_service.dart';
import '../../modules/common_setup/core_entity/data/service/core_entity_api_service.dart';
import '../../modules/common_setup/organization/data/service/organization_api_service.dart';
import '../../features/partners/data/services/partner_api_service.dart';

final bsApiClientProvider = Provider<BsApiClient>((ref) {
  return BsApiClient(ref.read(bsDioProvider));
});

final farAssetApiServiceProvider = Provider<FarAssetApiService>((ref) {
  return FarAssetApiService(ref.read(bsApiClientProvider));
});

final coreEntityApiServiceProvider = Provider<CoreEntityApiService>((ref) {
  return CoreEntityApiService(ref.read(bsApiClientProvider));
});

final organizationApiServiceProvider = Provider<OrganizationApiService>((ref) {
  return OrganizationApiService(ref.read(bsApiClientProvider));
});

final partnerApiServiceProvider = Provider<PartnerApiService>((ref) {
  return PartnerApiService(ref.read(bsApiClientProvider));
});
