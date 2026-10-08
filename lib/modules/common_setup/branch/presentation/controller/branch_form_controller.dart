/*
===============================================================================
BizSoft Frontend Framework
===============================================================================

File Name    : branch_form_controller.dart
Purpose      : Branch form controller.

===============================================================================
*/

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

import '../../../region/data/repository/region_repository.dart';
import '../../../region/data/service/region_api_service.dart';
import '../../../region/domain/model/region.dart';

import '../../../zone/data/repository/zone_repository.dart';
import '../../../zone/data/service/zone_api_service.dart';
import '../../../zone/domain/model/zone.dart';

import '../../../../../core/providers/bs_api_client_provider.dart';
import '../../../address/data/repository/address_repository.dart';
import '../../../address/data/service/address_api_service.dart';
import '../../data/repository/branch_repository.dart';
import '../../data/service/branch_api_service.dart';
import '../../domain/model/branch.dart';


final branchFormControllerProvider =
    StateNotifierProvider.family<
        BranchFormController,
        BranchFormState,
        int?>(
  (
    ref,
    branchId,
  ) {
    final currentLegalEntity =
        ref.watch(
      bsCurrentLegalEntityProvider,
    );

    return BranchFormController(
      repository: BranchRepository(
        BranchApiService(
          ref.watch(
            bsApiClientProvider,
          ),
        ),
      ),

      addressRepository: AddressRepository(
        AddressApiService(
          ref.watch(
            bsApiClientProvider,
          ),
        ),
      ),

      regionRepository: RegionRepository(
        RegionApiService(
          ref.watch(
            bsApiClientProvider,
          ),
        ),
      ),

      zoneRepository: ZoneRepository(
        ZoneApiService(
          ref.watch(
            bsApiClientProvider,
          ),
        ),
      ),

      branchId: branchId,

      currentLegalEntityId:
          currentLegalEntity?.id,
    );
  },
);


class BranchFormState {
  const BranchFormState({
    this.branch,
    this.branchId,
    this.legalEntityId,

    
    this.branchCode = '',
    this.branchName = '',
    this.branchType,

    
    this.regionId,
    this.regionCode,
    this.regionName,
    this.timezoneName,

    
    this.zoneId,
    this.zoneCode,
    this.zoneName,
    this.timezoneAbbreviation,
    this.utcOffset,

    
    this.regions = const <Region>[],
    this.zones = const <Zone>[],
    this.regionsLoading = false,
    this.zonesLoading = false,

    
    this.addressId,
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.township = '',
    this.city,
    this.addressRegionId,
    this.addressZoneId,
    this.addressRegionCode,
    this.addressZoneCode,
    this.addressPostalCode = '',

    
    this.latitude,
    this.longitude,

    
    this.isHeadOffice = false,
    this.isBankBranch = false,
    this.isCostCenter = false,
    this.isProfitCenter = false,
    this.isInventoryStorable = false,
    this.isAssetAssignable = false,

    
    this.isActive = true,
    this.effectiveFrom,
    this.effectiveTo,

    
    this.loading = false,
    this.saving = false,
    this.isDirty = false,
    this.error,
    this.loadVersion = 0,
  });

  final Branch? branch;

  final int? branchId;
  final int? legalEntityId;

  final String branchCode;
  final String branchName;
  final String? branchType;


  final int? regionId;
  final String? regionCode;
  final String? regionName;
  final String? timezoneName;


  final int? zoneId;
  final String? zoneCode;
  final String? zoneName;
  final String? timezoneAbbreviation;
  final String? utcOffset;

  final List<Region> regions;
  final List<Zone> zones;

  final bool regionsLoading;
  final bool zonesLoading;


  final int? addressId;

  final String? addressLine1;
  final String? addressLine2;
  final String? township;
  final String? city;

  final int? addressRegionId;
  final int? addressZoneId;

  final String? addressRegionCode;
  final String? addressZoneCode;

  final String? addressPostalCode;


  final double? latitude;
  final double? longitude;


  final bool isHeadOffice;
  final bool isBankBranch;

  final bool isCostCenter;
  final bool isProfitCenter;
  final bool isInventoryStorable;
  final bool isAssetAssignable;

  final bool isActive;

  final DateTime? effectiveFrom;
  final DateTime? effectiveTo;

  final bool loading;
  final bool saving;
  final bool isDirty;

  final String? error;

  final int loadVersion;

  static const Object _unset = Object();

  BranchFormState copyWith({
    Branch? branch,

    int? branchId,
    int? legalEntityId,

    String? branchCode,
    String? branchName,
    String? branchType,

    int? regionId,
    String? regionCode,
    String? regionName,
    String? timezoneName,

    int? zoneId,
    String? zoneCode,
    String? zoneName,
    String? timezoneAbbreviation,
    String? utcOffset,

    List<Region>? regions,
    List<Zone>? zones,

    bool? regionsLoading,
    bool? zonesLoading,

    Object? addressId = _unset,

    Object? addressLine1 = _unset,
    Object? addressLine2 = _unset,
    Object? township = _unset,
    Object? city = _unset,

    Object? addressRegionId = _unset,
    Object? addressZoneId = _unset,

    Object? addressRegionCode = _unset,
    Object? addressZoneCode = _unset,

    Object? addressPostalCode = _unset,

    double? latitude,
    double? longitude,

    bool clearLocation = false,
    bool clearZone = false,

    bool? isHeadOffice,
    bool? isBankBranch,

    bool? isCostCenter,
    bool? isProfitCenter,
    bool? isInventoryStorable,
    bool? isAssetAssignable,

    bool? isActive,

    Object? effectiveFrom = _unset,
    Object? effectiveTo = _unset,

    bool? loading,
    bool? saving,
    bool? isDirty,

    String? error,
    bool clearError = false,

    int? loadVersion,
  }) {
    return BranchFormState(
      branch:
          branch ?? this.branch,

      branchId:
          branchId ?? this.branchId,

      legalEntityId:
          legalEntityId ?? this.legalEntityId,

      branchCode:
          branchCode ?? this.branchCode,

      branchName:
          branchName ?? this.branchName,

      branchType:
          branchType ?? this.branchType,

      regionId:
          regionId ?? this.regionId,

      regionCode:
          regionCode ?? this.regionCode,

      regionName:
          regionName ?? this.regionName,

      timezoneName:
          timezoneName ?? this.timezoneName,


      zoneId:
          clearZone
              ? null
              : zoneId ?? this.zoneId,

      zoneCode:
          clearZone
              ? null
              : zoneCode ?? this.zoneCode,

      zoneName:
          clearZone
              ? null
              : zoneName ?? this.zoneName,

      timezoneAbbreviation:
          clearZone
              ? null
              : timezoneAbbreviation ??
                  this.timezoneAbbreviation,

      utcOffset:
          clearZone
              ? null
              : utcOffset ?? this.utcOffset,

      regions:
          regions ?? this.regions,

      zones:
          zones ?? this.zones,

      regionsLoading:
          regionsLoading ??
              this.regionsLoading,

      zonesLoading:
          zonesLoading ??
              this.zonesLoading,

      addressId:
          addressId == _unset
              ? this.addressId
              : addressId as int?,

      addressLine1:
          addressLine1 == _unset
              ? this.addressLine1
              : addressLine1 as String?,

      addressLine2:
          addressLine2 == _unset
              ? this.addressLine2
              : addressLine2 as String?,

      township:
          township == _unset
              ? this.township
              : township as String?,

      city:
          city == _unset
              ? this.city
              : city as String?,

      addressRegionId:
          addressRegionId == _unset
              ? this.addressRegionId
              : addressRegionId as int?,

      addressZoneId:
          addressZoneId == _unset
              ? this.addressZoneId
              : addressZoneId as int?,

      addressRegionCode:
          addressRegionCode == _unset
              ? this.addressRegionCode
              : addressRegionCode as String?,

      addressZoneCode:
          addressZoneCode == _unset
              ? this.addressZoneCode
              : addressZoneCode as String?,

      addressPostalCode:
          addressPostalCode == _unset
              ? this.addressPostalCode
              : addressPostalCode as String?,

     
      latitude:
          clearLocation
              ? null
              : latitude ?? this.latitude,

      longitude:
          clearLocation
              ? null
              : longitude ?? this.longitude,

     
      isHeadOffice:
          isHeadOffice ??
              this.isHeadOffice,

      isBankBranch:
          isBankBranch ??
              this.isBankBranch,

      isCostCenter:
          isCostCenter ??
              this.isCostCenter,

      isProfitCenter:
          isProfitCenter ??
              this.isProfitCenter,

      isInventoryStorable:
          isInventoryStorable ??
              this.isInventoryStorable,

      isAssetAssignable:
          isAssetAssignable ??
              this.isAssetAssignable,

      isActive:
          isActive ?? this.isActive,

      effectiveFrom:
          effectiveFrom == _unset
              ? this.effectiveFrom
              : effectiveFrom as DateTime?,

      effectiveTo:
          effectiveTo == _unset
              ? this.effectiveTo
              : effectiveTo as DateTime?,

      loading:
          loading ?? this.loading,

      saving:
          saving ?? this.saving,

      isDirty:
          isDirty ?? this.isDirty,

      error:
          clearError
              ? null
              : error ?? this.error,

      loadVersion:
          loadVersion ??
              this.loadVersion,
    );
  }
}

class BranchFormController
    extends StateNotifier<BranchFormState> {

  BranchFormController({
    required BranchRepository repository,
    required AddressRepository addressRepository,
    required RegionRepository regionRepository,
    required ZoneRepository zoneRepository,
    required int? branchId,
    required int? currentLegalEntityId,
  })  : _repository = repository,
        _addressRepository = addressRepository,
        _regionRepository = regionRepository,
        _zoneRepository = zoneRepository,
        _branchId = branchId,
        super(
          BranchFormState(
            branchId: branchId,
            legalEntityId:
                currentLegalEntityId,
            loading:
                branchId != null,
          ),
        ) {
    _loadLookups();

    if (branchId != null) {
      _load(branchId);
    }
  }

  final BranchRepository _repository;

  final AddressRepository _addressRepository;

  final RegionRepository _regionRepository;

  final ZoneRepository _zoneRepository;

  final int? _branchId;

 
  Future<void> _loadLookups() async {
    state = state.copyWith(
      regionsLoading: true,
      clearError: true,
    );

    try {
      final regions =
          await _regionRepository.getRegions();

      state = state.copyWith(
        regions: regions,
        regionsLoading: false,
        clearError: true,
      );

      
      if (state.regionId != null) {
        await _loadZones(
          state.regionId!,
        );
      }
    } catch (error) {
      state = state.copyWith(
        regionsLoading: false,
        error:
            'Unable to load regions: $error',
      );
    }
  }

  Future<void> _loadZones(
    int regionId,
  ) async {
    state = state.copyWith(
      zonesLoading: true,
      clearError: true,
    );

    try {
      final zones =
          await _zoneRepository.getZones(
        regionId: regionId,
      );

      state = state.copyWith(
        zones: zones,
        zonesLoading: false,
        clearError: true,
      );
    } catch (error) {
      state = state.copyWith(
        zones:
            const <Zone>[],
        zonesLoading: false,
        error:
            'Unable to load zones: $error',
      );
    }
  }

  Future<void> _load(
    int id,
  ) async {
    try {
      final branch =
          await _repository.getBranchById(id);

      final region =
          branch.regionDetail;

      final zone =
          branch.zoneDetail;

      final address =
          branch.addressDetail;

      final addressRegion =
          address?.regionDetail;

      final addressZone =
          address?.zoneDetail;

      state = state.copyWith(
        branch: branch,

        branchId:
            branch.id,

        legalEntityId:
            branch.legalEntity,

        
        branchCode:
            branch.branchCode,

        branchName:
            branch.branchName,

        branchType:
            branch.branchType.trim().isEmpty
                ? null
                : branch.branchType,

        
        regionId:
            branch.region,

        regionCode:
            region?.regionCode,

        regionName:
            region?.regionName,

        timezoneName:
            region?.timezoneName,

        
        zoneId:
            branch.zone,

        zoneCode:
            zone?.zoneCode,

        zoneName:
            zone?.zoneName,

        timezoneAbbreviation:
            zone?.timezoneAbbreviation,

        utcOffset:
            zone?.utcOffset,

        
        addressId:
            branch.address,

        addressLine1:
            address?.addressLine1 ?? '',

        addressLine2:
            address?.addressLine2 ?? '',

        township:
            address?.township ?? '',

        city:
            address?.city ?? '',

        addressRegionId:
            address?.region,

        addressZoneId:
            address?.zone,

        addressRegionCode:
            addressRegion?.regionCode,

        addressZoneCode:
            addressZone?.zoneCode,

        addressPostalCode:
            address?.postalCode ?? '',

        
        latitude:
            branch.latitude,

        longitude:
            branch.longitude,

        isHeadOffice:
            branch.isHeadOffice,

        isBankBranch:
            branch.isBankBranch,

        isCostCenter:
            branch.isCostCenter,

        isProfitCenter:
            branch.isProfitCenter,

        isInventoryStorable:
            branch.isInventoryStorable,

        isAssetAssignable:
            branch.isAssetAssignable,

        isActive:
            branch.isActive,

        effectiveFrom:
            branch.effectiveFrom,

        effectiveTo:
            branch.effectiveTo,

        loading: false,

        isDirty: false,

        clearError: true,

        loadVersion:
            state.loadVersion + 1,
      );

      
      if (branch.region != null) {
        await _loadZones(
          branch.region!,
        );
      }
    } catch (error) {
      state = state.copyWith(
        loading: false,
        error:
            error.toString(),
      );
    }
  }

  void updateBranchCode(
    String value,
  ) {
    state = state.copyWith(
      branchCode: value,
      isDirty: true,
      clearError: true,
    );
  }
  
  void updateBranchName(
    String value,
  ) {
    state = state.copyWith(
      branchName: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateBranchType(
    String? value,
  ) {
    state = state.copyWith(
      branchType: value,
      isDirty: true,
      clearError: true,
    );
  }

  Future<void> updateRegion(
    int? value,
  ) async {
    Region? selectedRegion;

    if (value != null) {
      for (final region in state.regions) {
        if (region.id == value) {
          selectedRegion = region;
          break;
        }
      }
    }

    
    state = state.copyWith(
      regionId: value,

      regionCode:
          selectedRegion?.regionCode,

      regionName:
          selectedRegion?.regionName,

      timezoneName:
          selectedRegion?.timezoneName,

      clearZone: true,

      clearLocation: true,

      zones:
          const <Zone>[],

      addressRegionId:
          value,

      addressRegionCode:
          selectedRegion?.regionCode,

      addressZoneId: null,

      addressZoneCode: null,

      isDirty: true,

      clearError: true,
    );

    if (value != null) {
      await _loadZones(
        value,
      );
    }
  }

  void updateZone(
    int? value,
  ) {
    Zone? selectedZone;

    if (value != null) {
      for (final zone in state.zones) {
        if (zone.id == value) {
          selectedZone = zone;
          break;
        }
      }
    }

    state = state.copyWith(
      zoneId: value,

      zoneCode:
          selectedZone?.zoneCode,

      zoneName:
          selectedZone?.zoneName,

      timezoneAbbreviation:
          selectedZone?.timezoneAbbreviation,

      utcOffset:
          selectedZone?.utcOffset,

      clearLocation: true,

      addressZoneId:
          value,

      addressZoneCode:
          selectedZone?.zoneCode,

      addressRegionId:
          state.regionId,

      addressRegionCode:
          state.regionCode,

      isDirty: true,

      clearError: true,
    );
  }

  void updateLocation({
    required double? latitude,
    required double? longitude,
  }) {
    state = state.copyWith(
      latitude:latitude,
          

      longitude:longitude,
         

      isDirty: true,

      clearError: true,
    );
  }

  
  void clearLocation() {
    state = state.copyWith(
      clearLocation: true,
      isDirty: true,
      clearError: true,
    );
  }

  void updateAddressLine1(
    String? value,
  ) {
    state = state.copyWith(
      addressLine1: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateAddressLine2(
    String? value,
  ) {
    state = state.copyWith(
      addressLine2: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateTownship(
    String? value,
  ) {
    state = state.copyWith(
      township: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateCity(
    String? value,
  ) {
    state = state.copyWith(
      city: value,
      isDirty: true,
      clearError: true,
    );
  }

  void setAddress({
    required String addressLine1,
    String? addressLine2,
    required String township,
    required String city,
    String? postalCode,
  }) {
    state = state.copyWith(
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      township: township,
      city: city,
      addressPostalCode: postalCode,
      addressRegionId: state.regionId,
      addressZoneId: state.zoneId,
      addressRegionCode: state.regionCode,
      addressZoneCode: state.zoneCode,
      isDirty: true,
      clearError: true,
    );
  }

  void updatePostalCode(
    String? value,
  ) {
    state = state.copyWith(
      addressPostalCode: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsHeadOffice(
    bool value,
  ) {
    state = state.copyWith(
      isHeadOffice: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsBankBranch(
    bool value,
  ) {
    state = state.copyWith(
      isBankBranch: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsCostCenter(
    bool value,
  ) {
    state = state.copyWith(
      isCostCenter: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsProfitCenter(
    bool value,
  ) {
    state = state.copyWith(
      isProfitCenter: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsInventoryStorable(
    bool value,
  ) {
    state = state.copyWith(
      isInventoryStorable: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsAssetAssignable(
    bool value,
  ) {
    state = state.copyWith(
      isAssetAssignable: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateIsActive(
    bool value,
  ) {
    state = state.copyWith(
      isActive: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateEffectiveFrom(
    DateTime? value,
  ) {
    state = state.copyWith(
      effectiveFrom: value,
      isDirty: true,
      clearError: true,
    );
  }

  void updateEffectiveTo(
    DateTime? value,
  ) {
    state = state.copyWith(
      effectiveTo: value,
      isDirty: true,
      clearError: true,
    );
  }

  bool validate() {
    if (state.legalEntityId == null) {
      state = state.copyWith(
        error:
            'Legal Entity is required.',
      );
      return false;
    }

    if (state.branchCode.trim().isEmpty) {
      state = state.copyWith(
        error:
            'Branch Code is required.',
      );
      return false;
    }

    if (state.branchName.trim().isEmpty) {
      state = state.copyWith(
        error:
            'Branch Name is required.',
      );
      return false;
    }

    if (state.branchType == null ||
        state.branchType!.trim().isEmpty) {
      state = state.copyWith(
        error:
            'Branch Type is required.',
      );
      return false;
    }

    if (state.regionId == null) {
      state = state.copyWith(
        error:
            'Region is required.',
      );
      return false;
    }

    if (state.zoneId == null) {
      state = state.copyWith(
        error:
            'Zone is required.',
      );
      return false;
    }

    final hasAddress =
        state.addressId != null ||
        (state.addressLine1?.trim().isNotEmpty ?? false) ||
        (state.addressLine2?.trim().isNotEmpty ?? false) ||
        (state.township?.trim().isNotEmpty ?? false) ||
        (state.city?.trim().isNotEmpty ?? false) ||
        (state.addressPostalCode?.trim().isNotEmpty ?? false);

    if (hasAddress) {
      if (state.addressLine1?.trim().isEmpty ?? true) {
        state = state.copyWith(error: 'Address Line 1 is required.');
        return false;
      }
      if (state.township?.trim().isEmpty ?? true) {
        state = state.copyWith(error: 'Township is required.');
        return false;
      }
      if (state.city?.trim().isEmpty ?? true) {
        state = state.copyWith(error: 'City is required.');
        return false;
      }
    }

    if (state.latitude == null ||
        state.longitude == null) {
      state = state.copyWith(
        error:
            'Please select branch location on the map.',
      );
      return false;
    }

    if (state.latitude! < -90 ||
        state.latitude! > 90) {
      state = state.copyWith(
        error:
            'Invalid latitude.',
      );
      return false;
    }

    if (state.longitude! < -180 ||
        state.longitude! > 180) {
      state = state.copyWith(
        error:
            'Invalid longitude.',
      );
      return false;
    }

    if (state.effectiveFrom != null &&
        state.effectiveTo != null &&
        state.effectiveTo!.isBefore(
          state.effectiveFrom!,
        )) {
      state = state.copyWith(
        error:
            'Effective To cannot be before Effective From.',
      );
      return false;
    }

    return true;
  }

 
  Future<int?> _saveAddressIfNeeded() async {
    final hasAddress =
        state.addressId != null ||
        (state.addressLine1?.trim().isNotEmpty ?? false) ||
        (state.addressLine2?.trim().isNotEmpty ?? false) ||
        (state.township?.trim().isNotEmpty ?? false) ||
        (state.city?.trim().isNotEmpty ?? false) ||
        (state.addressPostalCode?.trim().isNotEmpty ?? false);

    if (!hasAddress) return null;

    final regionId = state.regionId;
    final zoneId = state.zoneId;
    if (regionId == null || zoneId == null) {
      throw Exception('Region and Zone are required for address.');
    }

    final addressLine1 = state.addressLine1?.trim() ?? '';
    final township = state.township?.trim() ?? '';
    final city = state.city?.trim() ?? '';
    if (addressLine1.isEmpty || township.isEmpty || city.isEmpty) {
      throw Exception('Address Line 1, Township and City are required.');
    }

    final addressLine2 = state.addressLine2?.trim();
    final postalCode = state.addressPostalCode?.trim();

    final address = state.addressId == null
        ? await _addressRepository.createAddress(
            addressLine1: addressLine1,
            addressLine2: addressLine2?.isEmpty == true ? null : addressLine2,
            township: township,
            city: city,
            region: regionId,
            zone: zoneId,
            postalCode: postalCode?.isEmpty == true ? null : postalCode,
            isActive: state.isActive,
          )
        : await _addressRepository.updateAddress(
            id: state.addressId!,
            addressLine1: addressLine1,
            addressLine2: addressLine2?.isEmpty == true ? null : addressLine2,
            township: township,
            city: city,
            region: regionId,
            zone: zoneId,
            postalCode: postalCode?.isEmpty == true ? null : postalCode,
            isActive: state.isActive,
          );

    if (address.id <= 0) {
      throw Exception('Address was saved but no address ID was returned.');
    }

    state = state.copyWith(
      addressId: address.id,
      addressRegionId: regionId,
      addressZoneId: zoneId,
      addressRegionCode: state.regionCode,
      addressZoneCode: state.zoneCode,
    );

    return address.id;
  }

  Future<Branch?> save() async {
    debugPrint(
    'Branch Location => '
    'lat=${state.latitude}, '
    'lng=${state.longitude}',
  );

  if (state.latitude == null ||
      state.longitude == null) {

    debugPrint(
      'ERROR: Branch location is missing',
    );

    return null;
  }
    if (!validate()) {
      return null;
    }

    state = state.copyWith(
      saving: true,
      clearError: true,
    );

    try {
      final addressId = await _saveAddressIfNeeded();

      final Branch saved;

      if (_branchId == null) {
        saved =
            await _repository.createBranch(
          legalEntity:
              state.legalEntityId!,

          branchCode:
              state.branchCode
                  .trim()
                  .toUpperCase(),

          branchName:
              state.branchName.trim(),

          branchType:
              state.branchType!.trim(),

          region:
              state.regionId,

          zone:
              state.zoneId,

          address:
              addressId,

          latitude:
              state.latitude,

          longitude:
              state.longitude,

          isHeadOffice:
              state.isHeadOffice,

          isBankBranch:
              state.isBankBranch,

          isCostCenter:
              state.isCostCenter,

          isProfitCenter:
              state.isProfitCenter,

          isInventoryStorable:
              state.isInventoryStorable,

          isAssetAssignable:
              state.isAssetAssignable,

          isActive:
              state.isActive,

          effectiveFrom:
              state.effectiveFrom,

          effectiveTo:
              state.effectiveTo,
        );
      }

      
      else {
        saved =
            await _repository.updateBranch(
          id:
              _branchId,

          legalEntity:
              state.legalEntityId!,

          branchCode:
              state.branchCode
                  .trim()
                  .toUpperCase(),

          branchName:
              state.branchName.trim(),

          branchType:
              state.branchType!.trim(),

          region:
              state.regionId,

          zone:
              state.zoneId,

          address:
              addressId,

          latitude:
              state.latitude,

          longitude:
              state.longitude,

          isHeadOffice:
              state.isHeadOffice,

          isBankBranch:
              state.isBankBranch,

          isCostCenter:
              state.isCostCenter,

          isProfitCenter:
              state.isProfitCenter,

          isInventoryStorable:
              state.isInventoryStorable,

          isAssetAssignable:
              state.isAssetAssignable,

          isActive:
              state.isActive,

          effectiveFrom:
              state.effectiveFrom,

          effectiveTo:
              state.effectiveTo,
        );
      }

      
      final region =
          saved.regionDetail;

      final zone =
          saved.zoneDetail;

      final address =
          saved.addressDetail;

      final addressRegion =
          address?.regionDetail;

      final addressZone =
          address?.zoneDetail;

      state = state.copyWith(
        branch:
            saved,

        branchId:
            saved.id,

        legalEntityId:
            saved.legalEntity,

        branchCode:
            saved.branchCode,

        branchName:
            saved.branchName,

        branchType:
            saved.branchType,

        regionId:
            saved.region,

        regionCode:
            region?.regionCode,

        regionName:
            region?.regionName,

        timezoneName:
            region?.timezoneName,

        zoneId:
            saved.zone,

        zoneCode:
            zone?.zoneCode,

        zoneName:
            zone?.zoneName,

        timezoneAbbreviation:
            zone?.timezoneAbbreviation,

        utcOffset:
            zone?.utcOffset,

        addressId:
            saved.address,

        addressLine1:
            address?.addressLine1 ?? '',

        addressLine2:
            address?.addressLine2 ?? '',

        township:
            address?.township ?? '',

        city:
            address?.city ?? '',

        addressRegionId:
            address?.region,

        addressZoneId:
            address?.zone,

        addressRegionCode:
            addressRegion?.regionCode,

        addressZoneCode:
            addressZone?.zoneCode,

        addressPostalCode:
            address?.postalCode ?? '',

        latitude:
            saved.latitude,

        longitude:
            saved.longitude,

        isHeadOffice:
            saved.isHeadOffice,

        isBankBranch:
            saved.isBankBranch,

        isCostCenter:
            saved.isCostCenter,

        isProfitCenter:
            saved.isProfitCenter,

        isInventoryStorable:
            saved.isInventoryStorable,

        isAssetAssignable:
            saved.isAssetAssignable,

        isActive:
            saved.isActive,

        effectiveFrom:
            saved.effectiveFrom,

        effectiveTo:
            saved.effectiveTo,

        saving: false,

        isDirty: false,

        clearError: true,

        loadVersion:
            state.loadVersion + 1,
      );

      return saved;
    } catch (error) {
      state = state.copyWith(
        saving: false,
        error:
            error.toString(),
      );

      return null;
    }
  }
}