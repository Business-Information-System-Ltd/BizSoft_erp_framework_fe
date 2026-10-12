// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../../../core/providers/api_providers.dart';

// // ═══════════════════════════════════════════════════════════════
// // LEGAL ENTITY — /api/core-entity/
// // ═══════════════════════════════════════════════════════════════
// final legalEntitiesProvider = FutureProvider<List<Map<String, dynamic>>>((
//   ref,
// ) async {
//   final svc = ref.read(coreEntityApiServiceProvider);
//   final response = await svc.list();
//   final results = response['results'];
//   if (results is! List) return [];
//   return results
//       .whereType<Map>()
//       .map((e) => Map<String, dynamic>.from(e))
//       .toList();
// });

// // ═══════════════════════════════════════════════════════════════
// // ORGANIZATION — /api/organizations/
// // ═══════════════════════════════════════════════════════════════
// final organizationsProvider = FutureProvider<List<Map<String, dynamic>>>((
//   ref,
// ) async {
//   final svc = ref.read(organizationApiServiceProvider);
//   final response = await svc.list();
//   final results = response['results'];
//   if (results is! List) return [];
//   return results
//       .whereType<Map>()
//       .map((e) => Map<String, dynamic>.from(e))
//       .toList();
// });

// // ═══════════════════════════════════════════════════════════════
// // PARTNER — /api/partners/
// // ═══════════════════════════════════════════════════════════════
// final partnersProvider = FutureProvider<List<Map<String, dynamic>>>((
//   ref,
// ) async {
//   final svc = ref.read(partnerApiServiceProvider);
//   final response = await svc.listPartners(); // 👈 listPartners()
//   final results = response['results'];
//   if (results is! List) return [];
//   return results
//       .whereType<Map>()
//       .map((e) => Map<String, dynamic>.from(e))
//       .toList();
// });
// far_asset_dropdown_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/bs_api_client_provider.dart';
import '../../data/service/far_asset_api_service.dart';

final farAssetApiServiceProvider = Provider<FarAssetApiService>((ref) {
  return FarAssetApiService(ref.watch(bsApiClientProvider));
});

// ─── Legal Entities ───
final legalEntitiesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final svc = ref.read(farAssetApiServiceProvider);
  return svc.getLegalEntities();
});

// ─── Organizations ───
final organizationsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final svc = ref.read(farAssetApiServiceProvider);
  return svc.getOrganizations();
});

// ─── Partners ───
final partnersProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final svc = ref.read(farAssetApiServiceProvider);
  return svc.getPartners();
});
