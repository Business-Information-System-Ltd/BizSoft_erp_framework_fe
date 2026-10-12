import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/providers/api_providers.dart';

// ═══════════════════════════════════════════════════════════════
// LEGAL ENTITY — /api/core-entity/
// ═══════════════════════════════════════════════════════════════
final legalEntitiesProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final svc = ref.read(coreEntityApiServiceProvider);
  final response = await svc.list();
  final results = response['results'];
  if (results is! List) return [];
  return results
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
});

// ═══════════════════════════════════════════════════════════════
// ORGANIZATION — /api/organizations/
// ═══════════════════════════════════════════════════════════════
final organizationsProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final svc = ref.read(organizationApiServiceProvider);
  final response = await svc.list();
  final results = response['results'];
  if (results is! List) return [];
  return results
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
});

// ═══════════════════════════════════════════════════════════════
// PARTNER — /api/partners/
// ═══════════════════════════════════════════════════════════════
final partnersProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final svc = ref.read(partnerApiServiceProvider);
  final response = await svc.listPartners(); // 👈 listPartners()
  final results = response['results'];
  if (results is! List) return [];
  return results
      .whereType<Map>()
      .map((e) => Map<String, dynamic>.from(e))
      .toList();
});
