/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_repository.dart
 Purpose      : *   Converts Partner API data into domain models for UI providers.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import '../../domain/enums/partner_enums.dart';
import '../../domain/models/partner_model.dart';
import '../services/partner_api_service.dart';

class PartnerListPage {
  const PartnerListPage({
    required this.items,
    required this.count,
    required this.page,
    required this.hasNext,
    required this.hasPrevious,
  });

  final List<PartnerModel> items;
  final int count;
  final int page;
  final bool hasNext;
  final bool hasPrevious;
}

class PartnerRepository {
  const PartnerRepository(this._apiService);

  final PartnerApiService _apiService;

  Future<PartnerListPage> listPartners({
    String? search,
    PartnerType? partnerType,
    PartnerRoleType? roleType,
    PartnerStatus? status,
    int page = 1,
  }) async {
    final data = await _apiService.listPartners(
      search: search,
      partnerType: partnerType?.value,
      roleType: roleType?.value,
      status: status?.value,
      page: page,
    );
    final rawResults = data['results'];
    final rawItems = rawResults is List ? rawResults : data['items'];
    final items = rawItems is List
        ? rawItems.whereType<Map>().map((item) => PartnerModel.fromJson(Map<String, dynamic>.from(item))).toList()
        : <PartnerModel>[];
    return PartnerListPage(
      items: items,
      count: data['count'] is int ? data['count'] as int : items.length,
      page: page,
      hasNext: data['next'] != null,
      hasPrevious: data['previous'] != null,
    );
  }

  Future<PartnerModel> getPartner(String id) async {
    final data = await _apiService.getPartner(id);
    return PartnerModel.fromJson(data);
  }

  Future<PartnerModel> createPartner(PartnerModel partner) async {
    final data = await _apiService.createPartner(partner.toJson());
    return PartnerModel.fromJson(data);
  }

  Future<PartnerModel> updatePartner(PartnerModel partner) async {
    final id = partner.id;
    if (id == null) {
      throw ArgumentError('Partner id is required for update.');
    }
    final data = await _apiService.updatePartner(id, partner.toJson());
    return PartnerModel.fromJson(data);
  }

  Future<void> activatePartner(String id) => _apiService.activatePartner(id);

  Future<void> blockPartner(String id) => _apiService.blockPartner(id);
}
