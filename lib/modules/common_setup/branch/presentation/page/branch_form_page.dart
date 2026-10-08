
/*
===============================================================================
BizSoft Frontend Framework
===============================================================================

File Name    : branch_form_page.dart
Purpose      : Branch create/edit master entry page.
Company      : BizSoft Systems

===============================================================================
*/

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import 'package:bizsoft_frontend_framework/shared/inputs/bs_date_field.dart';

import '../../../../../core/footer/bs_footer_message_provider.dart';
import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

import '../../../../../shared/buttons/bs_action_button.dart';
import '../../../../../shared/buttons/bs_cancel_button.dart';
import '../../../../../shared/buttons/bs_new_button.dart';
import '../../../../../shared/buttons/bs_save_button.dart';

import '../../../../../shared/inputs/bs_checkbox_field.dart';
import '../../../../../shared/inputs/bs_dropdown_field.dart';

import '../../../../../shared/layout/bs_detail_area.dart';
import '../../../../../shared/layout/bs_form_action_bar.dart';
import '../../../../../shared/layout/bs_form_row.dart';
import '../../../../../shared/layout/bs_master_entry_page.dart';

import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';

import '../../../region/domain/model/region.dart';
import '../../../zone/domain/model/zone.dart';

import '../controller/branch_form_controller.dart';
import '../widget/branch_form_section.dart';
import '../widget/branch_location_picker.dart';
import '../widget/branch_add_address_dialog.dart';


class BranchFormPage extends ConsumerStatefulWidget {
  const BranchFormPage({
    super.key,
    this.branchId,
  });

  final int? branchId;

  @override
  ConsumerState<BranchFormPage> createState() =>
      _BranchFormPageState();
}


class _BranchFormPageState
    extends ConsumerState<BranchFormPage> {

  final _formKey =
      GlobalKey<FormState>();

  final _branchCodeController =
      TextEditingController();

  final _branchNameController =
      TextEditingController();

  int _loadedVersion = -1;

  static const List<String>
      _branchTypeOptions = [
    'Head Office',
    'Bank Branch',
    'Service Office',
  ];

 
  @override
  void dispose() {
    _branchCodeController.dispose();
    _branchNameController.dispose();


    super.dispose();
  }

  LatLng? _mapCenter(
    BranchFormState state,
  ) {

    if (state.latitude != null &&
        state.longitude != null) {
      return LatLng(
        state.latitude!,
        state.longitude!,
      );
    }

   
    if (state.zoneId != null) {
      for (final zone in state.zones) {
        if (zone.id == state.zoneId) {

          if (zone.mapLatitude != null &&
              zone.mapLongitude != null) {

            return LatLng(
              zone.mapLatitude!,
              zone.mapLongitude!,
            );
          }
        }
      }
    }

    if (state.regionId != null) {
      for (final region in state.regions) {
        if (region.id == state.regionId) {

          if (region.mapLatitude != null &&
              region.mapLongitude != null) {

            return LatLng(
              region.mapLatitude!,
              region.mapLongitude!,
            );
          }
        }
      }
    }

    return null;
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    final provider =
        branchFormControllerProvider(
      widget.branchId,
    );

    final state =
        ref.watch(provider);

    final notifier =
        ref.read(provider.notifier);

    final isNew =
        widget.branchId == null;

    final currentLegalEntity =
        ref.watch(
      bsCurrentLegalEntityProvider,
    );

    final legalEntityName =
        currentLegalEntity == null
            ? ''
            : currentLegalEntity
                .legalEntityName;

    if (_loadedVersion !=
        state.loadVersion) {

      _loadedVersion =
          state.loadVersion;

      _branchCodeController.text =
          state.branchCode;

      _branchNameController.text =
          state.branchName;

    }

    
    final enabled =
        !state.loading &&
        !state.saving;

    
    return Form(
      key: _formKey,

      child: BsMasterEntryPage(

        routeMeta:
            BsMasterEntryRouteMeta(

          title:
              'Branch Basic Information',

          subtitle:
              isNew
                  ? 'Create branch profile'
                  : 'Edit branch profile',

          moduleCode:
              'COMMON',

          screenCode:
              'BRANCH',

          recordId:
              widget.branchId?.toString(),

          breadcrumb:
              BsBreadcrumb(
            items: [

              const BsBreadcrumbItem(
                label: 'Home',
                routePath: '/',
              ),

              const BsBreadcrumbItem(
                label: 'Common Setup',
              ),

              const BsBreadcrumbItem(
                label: 'Branch',
                routePath:
                    '/common/branches',
              ),

              BsBreadcrumbItem(
                label:
                    isNew
                        ? 'New'
                        : 'Edit',
              ),
            ],
          ),

          status:
              _buildPageStatus(state),
        ),

       
        pageActions: [

          BsActionButton(
            label:
                'Check Duplicate',

            icon:
                Icons.manage_search,

            onPressed:
                enabled
                    ? _checkDuplicate
                    : null,
          ),

          if (!isNew)
            BsNewButton(
              onPressed:
                  state.saving
                      ? null
                      : () => _openNew(
                          context,
                          state.isDirty,
                        ),
            ),
        ],

        
        basicInfo:
            BranchFormSection(

          legalEntityName:
              legalEntityName,

          branchCodeController:
              _branchCodeController,

          branchNameController:
              _branchNameController,

          branchType:
              state.branchType,

          branchTypeOptions:
              _branchTypeOptions,

          onBranchCodeChanged:
              notifier.updateBranchCode,

          onBranchNameChanged:
              notifier.updateBranchName,

          onBranchTypeChanged:
              notifier.updateBranchType,

          enabled:
              enabled,
        ),

        basicInfoTitle:
            'Basic Information',

        basicInfoStatus:
            state.isActive
                ? 'Active'
                : 'Inactive',

        detailContent:
            BsTabbedDetailArea(

          tabs: [

            BsDetailTab(

              title:
                  'Region / Zone',

              icon:
                  Icons.location_on_outlined,

              child:
                  _RegionZoneTab(

                regions:
                    state.regions,

                zones:
                    state.zones,

                selectedRegionId:
                    state.regionId,

                selectedZoneId:
                    state.zoneId,

                latitude:
                    state.latitude,

                longitude:
                    state.longitude,

                mapCenter:
                    _mapCenter(state),

                enabled:
                    enabled,

                regionsLoading:
                    state.regionsLoading,

                zonesLoading:
                    state.zonesLoading,

                onRegionChanged:
                    notifier.updateRegion,

                onZoneChanged:
                    notifier.updateZone,

                onLocationSelected:
                    (point) {

                  notifier.updateLocation(
                    latitude:
                        point?.latitude,

                    longitude:
                        point?.longitude,
                  );
                },
              ),
            ),

            
            BsDetailTab(

              title:
                  'Responsibility',

              icon:
                  Icons.assignment_ind_outlined,

              child:
                  _ResponsibilityTab(

                isCostCenter:
                    state.isCostCenter,

                isProfitCenter:
                    state.isProfitCenter,

                isInventoryStorable:
                    state.isInventoryStorable,

                isAssetAssignable:
                    state.isAssetAssignable,

                isHeadOffice:
                    state.isHeadOffice,

                isBankBranch:
                    state.isBankBranch,

                enabled:
                    enabled,

                onHeadOfficeChanged:
                    notifier.updateIsHeadOffice,

                onBankBranchChanged:
                    notifier.updateIsBankBranch,

                onCostCenterChanged:
                    notifier.updateIsCostCenter,

                onProfitCenterChanged:
                    notifier.updateIsProfitCenter,

                onInventoryStorableChanged:
                    notifier.updateIsInventoryStorable,

                onAssetAssignableChanged:
                    notifier.updateIsAssetAssignable,
              ),
            ),

            BsDetailTab(

              title:
                  'Address',

              icon:
                  Icons.home_outlined,

              child:
                  _AddressTab(
                
                township:
                    state.township,
                city:
                    state.city,
                postalCode:
                    state.addressPostalCode,
                    addressLine1:
                    state.addressLine1,
                addressLine2:
                    state.addressLine2,
                regionName:
                    state.regionName,
                zoneName:
                    state.zoneName,
                hasAddress:
                    state.addressId != null ||
                    (state.addressLine1?.trim().isNotEmpty ?? false),
                enabled:
                    enabled,
                onNewAddress:
                    () => _openAddressDialog(
                      context,
                      notifier,
                      state,
                    ),
              ),
            ),

           
            BsDetailTab(

              title:
                  'Status',

              icon:
                  Icons.toggle_on_outlined,

              child:
                  _StatusTab(

                isActive:
                    state.isActive,

                effectiveFrom:
                    state.effectiveFrom,

                effectiveTo:
                    state.effectiveTo,

                onEffectiveFromChanged:
                    notifier.updateEffectiveFrom,

                onEffectiveToChanged:
                    notifier.updateEffectiveTo,

                enabled:
                    enabled,

                onChanged:
                    notifier.updateIsActive,
              ),
            ),
          ],
        ),

       
        formActions:
            BsFormActionBar(

          isLoading:
              state.saving,

          cancelButton:
              BsCancelButton(
            onPressed:
                () => _cancel(
                  context,
                  state.isDirty,
                ),
          ),

          actions: [

            BsActionButton(
              label:
                  'Save Draft',

              icon:
                  Icons.mail_outline,

              onPressed:
                  state.saving
                      ? null
                      : () => _save(
                          context,
                          notifier,
                          draft: true,
                        ),
            ),
          ],

          saveButton:
              BsSaveButton(
            onPressed:
                state.saving
                    ? null
                    : () => _save(
                        context,
                        notifier,
                      ),
          ),
        ),

      
        isLoading:
            state.loading ||
            state.saving,

        isDirty:
            state.isDirty,

        onSaveShortcut:
            state.saving
                ? null
                : () => _save(
                    context,
                    notifier,
                  ),

        onCancelShortcut:
            () => _cancel(
              context,
              state.isDirty,
            ),
      ),
    );
  }

  Widget? _buildPageStatus(
    BranchFormState state,
  ) {
    if (state.error == null) {
      return null;
    }

    return Text(
      state.error!,
      style: TextStyle(
        color:
            Theme.of(context)
                .colorScheme
                .error,
      ),
    );
  }

 Future<void> _openAddressDialog(
  BuildContext context,
  BranchFormController notifier,
  BranchFormState state,
) async {
  if (state.regionId == null || state.zoneId == null) {
    ref
        .read(
          bsFooterMessageProvider.notifier,
        )
        .showValidation(
          'Please select Region and Zone first.',
        );
    return;
  }

  final selectedRegion = state.regions.firstWhere(
    (region) => region.id == state.regionId,
  );

  final selectedZone = state.zones.firstWhere(
    (zone) => zone.id == state.zoneId,
  );

  final regionTimezone =
      selectedRegion.regionName ?? '';

  final zoneTimezone =
      _zoneTimezoneText(selectedZone);

  final draft =
      await BranchAddAddressDialog.show(
    context,

    regionName:
        regionTimezone,

    zoneName:
        zoneTimezone,

    initialAddressLine1:
        state.addressLine1 ?? '',

    initialAddressLine2:
        state.addressLine2 ?? '',

    initialTownship:
        state.township ?? '',

    initialCity:
        state.city ?? '',

    initialPostalCode:
        state.addressPostalCode ?? '',
  );

  if (draft == null) {
    return;
  }

  notifier.setAddress(
    addressLine1:
        draft.addressLine1,

    addressLine2:
        draft.addressLine2,

    township:
        draft.township,

    city:
        draft.city,

    postalCode:
        draft.postalCode,
  );
}
String _zoneTimezoneText(
  Zone zone,
) {
  final offset =
      zone.utcOffset?.trim();

  final abbreviation =
      zone.timezoneAbbreviation?.trim();

  if (offset != null &&
      offset.isNotEmpty &&
      abbreviation != null &&
      abbreviation.isNotEmpty) {
    return 'UTC$offset · $abbreviation';
  }

  if (offset != null &&
      offset.isNotEmpty) {
    return 'UTC$offset';
  }

  if (abbreviation != null &&
      abbreviation.isNotEmpty) {
    return abbreviation;
  }

  return '';
}

  void _checkDuplicate() {
    final code =
        _branchCodeController.text.trim();

    final name =
        _branchNameController.text.trim();

    if (code.isEmpty &&
        name.isEmpty) {

      ref
          .read(
            bsFooterMessageProvider
                .notifier,
          )
          .showValidation(
            'Enter Branch Code or Branch Name before checking duplicate.',
          );

      return;
    }

    ref
        .read(
          bsFooterMessageProvider
              .notifier,
        )
        .showInfo(
          'Duplicate check is ready for backend integration.',
        );
  }

  Future<void> _save(
    BuildContext context,
    BranchFormController notifier, {
    bool draft = false,
  }) async {

    if (!(_formKey.currentState
            ?.validate() ??
        false)) {

      ref
          .read(
            bsFooterMessageProvider
                .notifier,
          )
          .showValidation(
            'Please correct the highlighted fields.',
          );

      return;
    }

    final saved =
        await notifier.save();

    if (saved != null &&
        context.mounted) {

      ref
          .read(
            bsFooterMessageProvider
                .notifier,
          )
          .showSuccess(
            draft
                ? 'Branch draft saved successfully.'
                : 'Branch saved successfully.',
          );

      context.go(
        '/common/branches',
      );

    } else if (context.mounted) {

      ref
          .read(
            bsFooterMessageProvider
                .notifier,
          )
          .showError(
            'Save failed. Please try again.',
          );
    }
  }

 
  Future<void> _openNew(
    BuildContext context,
    bool isDirty,
  ) async {

    final canLeave =
        await BsFormDirtyGuard
            .confirmDiscard(
      context,
      isDirty: isDirty,
    );

    if (canLeave &&
        context.mounted) {

      context.go(
        '/common/branches/new',
      );
    }
  }

  Future<void> _cancel(
    BuildContext context,
    bool isDirty,
  ) async {

    final canLeave =
        await BsFormDirtyGuard
            .confirmDiscard(
      context,
      isDirty: isDirty,
    );

    if (canLeave &&
        context.mounted) {

      context.go(
        '/common/branches',
      );
    }
  }
}

class _RegionZoneTab
    extends StatelessWidget {

  const _RegionZoneTab({
    required this.regions,
    required this.zones,
    required this.selectedRegionId,
    required this.selectedZoneId,
    required this.latitude,
    required this.longitude,
    required this.mapCenter,
    required this.enabled,
    required this.regionsLoading,
    required this.zonesLoading,
    required this.onRegionChanged,
    required this.onZoneChanged,
    required this.onLocationSelected,
  });

  final List<Region> regions;

  final List<Zone> zones;

  final int? selectedRegionId;

  final int? selectedZoneId;

  final double? latitude;

  final double? longitude;

  final LatLng? mapCenter;

  final bool enabled;

  final bool regionsLoading;

  final bool zonesLoading;

  final ValueChanged<int?>
      onRegionChanged;

  final ValueChanged<int?>
      onZoneChanged;

  final ValueChanged<LatLng?>
      onLocationSelected;

 String _zoneLabel(
  Zone zone,
) {
  final offset =
      zone.utcOffset?.trim();

  final abbreviation =
      zone.timezoneAbbreviation?.trim();

  if (offset != null &&
      offset.isNotEmpty &&
      abbreviation != null &&
      abbreviation.isNotEmpty) {
    return 'UTC$offset · $abbreviation';
  }

  if (offset != null &&
      offset.isNotEmpty) {
    return 'UTC$offset';
  }

  if (abbreviation != null &&
      abbreviation.isNotEmpty) {
    return abbreviation;
  }

  return '';
}
  @override
  Widget build(
    BuildContext context,
  ) {

    final regionItems =
    regions.map(
  (region) {

    return DropdownMenuItem<int>(
      value:
          region.id,

      child:
          Text(
        region.regionName ?? '',
        overflow:
            TextOverflow.ellipsis,
      ),
    );
  },
).toList();

    final zoneItems =
        zones.map(
      (zone) {

        return DropdownMenuItem<int>(
          value:
              zone.id,

          child:
              Text(
            _zoneLabel(zone),

            overflow:
                TextOverflow.ellipsis,
          ),
        );
      },
    ).toList();

    final selectedRegionExists =
        regionItems.any(
      (item) =>
          item.value ==
          selectedRegionId,
    );

    final selectedZoneExists =
        zoneItems.any(
      (item) =>
          item.value ==
          selectedZoneId,
    );

    return ListView(
      padding:
          const EdgeInsets.only(
        bottom: 24,
      ),

      children: [

        BsFormRow(
          fieldWidth:
              260,

          maxColumns:
              2,

          children: [

            BsDropdownField<int>(
              label:
                  'Region',

              value:
                  selectedRegionExists
                      ? selectedRegionId
                      : null,

              items:
                  regionItems,

              requiredField:
                  true,

              onChanged:
                  enabled &&
                          !regionsLoading
                      ? onRegionChanged
                      : null,

              helperText:
                  regionsLoading
                      ? 'Loading regions...'
                      : null,
            ),

           
            BsDropdownField<int>(
              label:
                  'Zone',

              value:
                  selectedZoneExists
                      ? selectedZoneId
                      : null,

              items:
                  zoneItems,

              requiredField:
                  true,

              onChanged:
                  enabled &&
                          selectedRegionId !=
                              null &&
                          !zonesLoading
                      ? onZoneChanged
                      : null,

              helperText:
                  selectedRegionId == null
                      ? 'Select a region first.'
                      : zonesLoading
                          ? 'Loading zones...'
                          : null,
            ),
          ],
        ),

        const SizedBox(
          height: 20,
        ),

       
        Text(
          'Branch Location',

          style:
              Theme.of(context)
                  .textTheme
                  .titleMedium,
        ),

        const SizedBox(
          height: 6,
        ),

        Text(
          'Click on the map to select the exact branch location.',

          style:
              Theme.of(context)
                  .textTheme
                  .bodySmall,
        ),

        const SizedBox(
          height: 12,
        ),

        BranchLocationPicker(

          latitude:
              latitude,

          longitude:
              longitude,

          mapCenter:
              mapCenter,

          enabled:
              enabled &&
              selectedRegionId != null &&
              selectedZoneId != null,

          onLocationSelected:
              onLocationSelected,
        ),
      ],
    );
  }
}

class _ResponsibilityTab
    extends StatelessWidget {

  const _ResponsibilityTab({
    required this.isHeadOffice,
    required this.isBankBranch,
    required this.enabled,
    required this.onHeadOfficeChanged,
    required this.onBankBranchChanged,
    required this.isCostCenter,
    required this.isProfitCenter,
    required this.isInventoryStorable,
    required this.isAssetAssignable,
    required this.onCostCenterChanged,
    required this.onProfitCenterChanged,
    required this.onInventoryStorableChanged,
    required this.onAssetAssignableChanged,
  });

  final bool isHeadOffice;
  final bool isBankBranch;

  final bool isCostCenter;
  final bool isProfitCenter;
  final bool isInventoryStorable;
  final bool isAssetAssignable;

  final bool enabled;

  final ValueChanged<bool>
      onHeadOfficeChanged;

  final ValueChanged<bool>
      onBankBranchChanged;

  final ValueChanged<bool>
      onCostCenterChanged;

  final ValueChanged<bool>
      onProfitCenterChanged;

  final ValueChanged<bool>
      onInventoryStorableChanged;

  final ValueChanged<bool>
      onAssetAssignableChanged;

  @override
  Widget build(
    BuildContext context,
  ) {
    return ListView(
      children: [

        BsFormRow(
          fieldWidth:
              260,

          maxColumns:
              3,

          children: [

            BsCheckboxField(
              label:
                  'Is_Cost_Center',

              value:
                  isCostCenter,

              onChanged:
                  enabled
                      ? onCostCenterChanged
                      : (_) {},
            ),

            BsCheckboxField(
              label:
                  'Is_Profit_Center',

              value:
                  isProfitCenter,

              onChanged:
                  enabled
                      ? onProfitCenterChanged
                      : (_) {},
            ),

            BsCheckboxField(
              label:
                  'Is_Inventory_Storable',

              value:
                  isInventoryStorable,

              onChanged:
                  enabled
                      ? onInventoryStorableChanged
                      : (_) {},
            ),

            BsCheckboxField(
              label:
                  'Is_Asset_Assignable',

              value:
                  isAssetAssignable,

              onChanged:
                  enabled
                      ? onAssetAssignableChanged
                      : (_) {},
            ),

            BsCheckboxField(
              label:
                  'Head Office',

              value:
                  isHeadOffice,

              onChanged:
                  enabled
                      ? onHeadOfficeChanged
                      : (_) {},
            ),

            BsCheckboxField(
              label:
                  'Bank Branch',

              value:
                  isBankBranch,

              onChanged:
                  enabled
                      ? onBankBranchChanged
                      : (_) {},
            ),
          ],
        ),
      ],
    );
  }
}

class _AddressTab extends StatelessWidget {
  const _AddressTab({
    required this.addressLine1,
    required this.addressLine2,
    required this.township,
    required this.city,
    required this.postalCode,
    required this.regionName,
    required this.zoneName,
    required this.hasAddress,
    required this.enabled,
    required this.onNewAddress,
  });

  final String? addressLine1;
  final String? addressLine2;
  final String? township;
  final String? city;
  final String? postalCode;
  final String? regionName;
  final String? zoneName;
  final bool hasAddress;
  final bool enabled;
  final VoidCallback onNewAddress;

  @override
  Widget build(BuildContext context) {
    return BsDetailGridSection(
      title: 'Address',
      subtitle: 'Branch address information.',
      height: 260,
      actions: [
        OutlinedButton.icon(
          onPressed: enabled ? onNewAddress : null,
          icon: const Icon(Icons.add, size: 18),
          label: Text(hasAddress ? 'Edit' : 'New'),
        ),
      ],
      child: hasAddress
          ? ListTile(
              dense: true,
              leading: const Icon(Icons.location_on_outlined),
              title: Text(
                [addressLine1, addressLine2]
                    .where((value) =>
                        value != null && value.trim().isNotEmpty)
                    .join(', '),
              ),
              subtitle: Text(
                [township, city, regionName, zoneName, postalCode]
                    .where((value) =>
                        value != null && value.trim().isNotEmpty)
                    .join(', '),
              ),
            )
          : const Center(
              child: Text('No address added.'),
            ),
    );
  }
}

class _StatusTab
    extends StatelessWidget {

  const _StatusTab({
    required this.isActive,
    required this.enabled,
    required this.onChanged,
    required this.effectiveFrom,
    required this.effectiveTo,
    required this.onEffectiveFromChanged,
    required this.onEffectiveToChanged,
  });

  final bool isActive;

  final bool enabled;

  final DateTime? effectiveFrom;

  final DateTime? effectiveTo;

  final ValueChanged<bool>
      onChanged;

  final ValueChanged<DateTime?>
      onEffectiveFromChanged;

  final ValueChanged<DateTime?>
      onEffectiveToChanged;

  
  Future<void> _selectDate(
    BuildContext context, {
    required DateTime? currentDate,
    required ValueChanged<DateTime?>
        onChanged,
  }) async {

    final now =
        DateTime.now();

    final selected =
        await showDatePicker(
      context: context,

      initialDate:
          currentDate ?? now,

      firstDate:
          DateTime(2000),

      lastDate:
          DateTime(2100),
    );

    if (selected != null) {
      onChanged(selected);
    }
  }

  String _formatDate(
    DateTime? date,
  ) {
    if (date == null) {
      return '';
    }

    final month =
        date.month
            .toString()
            .padLeft(
              2,
              '0',
            );

    final day =
        date.day
            .toString()
            .padLeft(
              2,
              '0',
            );

    return
        '${date.year}-$month-$day';
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return ListView(
      children: [

        BsFormRow(
          fieldWidth:
              260,

          maxColumns:
              3,

          children: [

            BsCheckboxField(
              label:
                  'Active',

              value:
                  isActive,

              onChanged:
                  enabled
                      ? onChanged
                      : (_) {},
            ),

            GestureDetector(
              behavior:
                  HitTestBehavior.opaque,

              onTap:
                  enabled
                      ? () => _selectDate(
                          context,

                          currentDate:
                              effectiveFrom,

                          onChanged:
                              onEffectiveFromChanged,
                        )
                      : null,

              child:
                  AbsorbPointer(
                child:
                    BsDateField(
                  label:
                      'Effective From',

                  controller:
                      TextEditingController(
                    text:
                        _formatDate(
                      effectiveFrom,
                    ),
                  ),
                ),
              ),
            ),

            GestureDetector(
              behavior:
                  HitTestBehavior.opaque,

              onTap:
                  enabled
                      ? () => _selectDate(
                          context,

                          currentDate:
                              effectiveTo,

                          onChanged:
                              onEffectiveToChanged,
                        )
                      : null,

              child:
                  AbsorbPointer(
                child:
                    BsDateField(
                  label:
                      'Effective To',

                  controller:
                      TextEditingController(
                    text:
                        _formatDate(
                      effectiveTo,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 12,
        ),

        Text(
          isActive
              ? 'This branch is active and available for use.'
              : 'This branch is inactive and cannot be used for new transactions.',

          style:
              Theme.of(context)
                  .textTheme
                  .bodySmall,
        ),
      ],
    );
  }
}