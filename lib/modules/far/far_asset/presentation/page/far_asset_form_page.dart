
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/footer/bs_footer_message_provider.dart';
import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

import '../../../../../shared/buttons/bs_action_button.dart';
import '../../../../../shared/buttons/bs_cancel_button.dart';
import '../../../../../shared/buttons/bs_new_button.dart';
import '../../../../../shared/buttons/bs_save_button.dart';

import '../../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../../shared/inputs/bs_text_field.dart';
import '../../../../../shared/inputs/bs_date_field.dart';

import '../../../../../shared/layout/bs_detail_area.dart';
import '../../../../../shared/layout/bs_form_action_bar.dart';
import '../../../../../shared/layout/bs_form_row.dart';
import '../../../../../shared/layout/bs_master_entry_page.dart';

import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';

import '../controller/far_asset_form_controller.dart';
import '../controller/far_asset_dropdown_provider.dart';

class FarAssetFormPage extends ConsumerStatefulWidget {
  const FarAssetFormPage({super.key, this.assetId});
  final int? assetId;

  @override
  ConsumerState<FarAssetFormPage> createState() => _FarAssetFormPageState();
}

class _FarAssetFormPageState extends ConsumerState<FarAssetFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _assetNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _serialNumberController = TextEditingController();
  final _quantityController = TextEditingController();
  final _usefulLifeController = TextEditingController();
  final _residualValueController = TextEditingController();
  final _invoiceNoController = TextEditingController();
  final _purchaseCostController = TextEditingController();
  final _otherCapitalizableCostController = TextEditingController();
  final _approvalReferenceController = TextEditingController();
  final _remarksController = TextEditingController();

  int _loadedVersion = -1;

  static const List<String> _assetTypeOptions = [
    'IT Equipment',
    'Furniture',
    'Vehicle',
  ];
  static const List<String> _unitOptions = ['Pcs', 'Set', 'Box', 'Unit'];
  static const List<String> _assetClassOptions = [
    'Class A',
    'Class B',
    'Class C',
  ];
  static const List<String> _assetCategoryOptions = [
    'Laptop',
    'Desktop',
    'Printer',
    'Furniture',
  ];
  static const List<String> _subCategoryOptions = [
    'Dell',
    'HP',
    'Lenovo',
    'Other',
  ];
  static const List<String> _depreciationMethodOptions = [
    'Straight Line',
    'Declining Balance',
    'None',
  ];
  static const List<String> _currencyOptions = ['MMK', 'USD', 'THB'];
  static const List<String> _accountOptions = ['1', '2', '3'];
  static const List<String> _costTypeOptions = [
    'Transportation',
    'Installation',
    'Customs Duty',
    'Other',
  ];

  @override
  void dispose() {
    _assetNameController.dispose();
    _descriptionController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _serialNumberController.dispose();
    _quantityController.dispose();
    _usefulLifeController.dispose();
    _residualValueController.dispose();
    _invoiceNoController.dispose();
    _purchaseCostController.dispose();
    _otherCapitalizableCostController.dispose();
    _approvalReferenceController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = farAssetFormControllerProvider(widget.assetId);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final isNew = widget.assetId == null;

    final currentLegalEntity = ref.watch(bsCurrentLegalEntityProvider);
    final legalEntityName = currentLegalEntity?.legalEntityName ?? '';

    final organizationsAsync = ref.watch(organizationsProvider);
    final partnersAsync = ref.watch(partnersProvider);

    if (_loadedVersion != state.loadVersion) {
      _loadedVersion = state.loadVersion;
      _assetNameController.text = state.assetName;
      _descriptionController.text = state.description ?? '';
      _brandController.text = state.brand ?? '';
      _modelController.text = state.model ?? '';
      _serialNumberController.text = state.serialNumber ?? '';
      _quantityController.text = state.quantity?.toString() ?? '';
      _usefulLifeController.text = state.usefulLife?.toString() ?? '';
      _residualValueController.text = state.residualValue?.toString() ?? '';
      _invoiceNoController.text = state.invoiceNo ?? '';
      _purchaseCostController.text = state.purchaseCost?.toString() ?? '';
      _otherCapitalizableCostController.text =
          state.otherCapitalizableCost?.toString() ?? '';
      _approvalReferenceController.text = state.approvalReference ?? '';
      _remarksController.text = state.remarks ?? '';
    }

    final enabled = !state.loading && !state.saving;

    return Form(
      key: _formKey,
      child: BsMasterEntryPage(
        routeMeta: BsMasterEntryRouteMeta(
          title: 'Fixed Asset Entry',
          subtitle: isNew
              ? 'Create fixed asset profile'
              : 'Edit fixed asset profile',
          moduleCode: 'FAR',
          screenCode: 'FAR_ASSET',
          recordId: widget.assetId?.toString(),
          breadcrumb: BsBreadcrumb(
            items: [
              const BsBreadcrumbItem(label: 'Home', routePath: '/'),
              const BsBreadcrumbItem(label: 'Fixed Assets Register'),
              const BsBreadcrumbItem(
                label: 'Core Entity Entry',
                routePath: '/far/assets',
              ),
              BsBreadcrumbItem(label: isNew ? 'New' : 'Edit'),
            ],
          ),
          draftNo: state.draftNo,
          source: state.source,
          draftDate: state.draftDate == null ? '' : _fmtDate(state.draftDate!),
          preparedBy: state.preparedBy,
          lastUpdated: state.lastUpdated == null
              ? ''
              : _fmtDateTime(state.lastUpdated!),
          statusText: state.status, // ← မှန်
        ),
        pageActions: [
          BsActionButton(
            label: 'Check Duplicate',
            icon: Icons.manage_search,
            onPressed: enabled ? _checkDuplicate : null,
          ),
          if (!isNew)
            BsNewButton(
              onPressed: state.saving
                  ? null
                  : () => _openNew(context, state.isDirty),
            ),
        ],
        basicInfo: _buildBasicInfoSection(
          state: state,
          notifier: notifier,
          legalEntityName: legalEntityName,
          enabled: enabled,
        ),
        basicInfoTitle: 'Basic Asset Information',
        basicInfoStatus: state.status,
        detailContent: BsTabbedDetailArea(
          tabs: [
            BsDetailTab(
              title: 'Classification',
              icon: Icons.category_outlined,
              child: _ClassificationTab(
                state: state,
                notifier: notifier,
                usefulLifeController: _usefulLifeController,
                residualValueController: _residualValueController,
                assetClassOptions: _assetClassOptions,
                assetCategoryOptions: _assetCategoryOptions,
                subCategoryOptions: _subCategoryOptions,
                depreciationMethodOptions: _depreciationMethodOptions,
              ),
            ),
            BsDetailTab(
              title: 'Location and Responsibility',
              icon: Icons.location_on_outlined,
              child: _LocationTab(
                state: state,
                notifier: notifier,
                organizationsAsync: organizationsAsync,
                partnersAsync: partnersAsync,
              ),
            ),
            BsDetailTab(
              title: 'Financial Information',
              icon: Icons.attach_money_outlined,
              child: _FinancialTab(
                state: state,
                notifier: notifier,
                partnersAsync: partnersAsync,
                invoiceNoController: _invoiceNoController,
                purchaseCostController: _purchaseCostController,
                otherCostController: _otherCapitalizableCostController,
                currencyOptions: _currencyOptions,
                accountOptions: _accountOptions,
                onAddCost: _openAddCostDialog,
              ),
            ),
            BsDetailTab(
              title: 'Documents / References',
              icon: Icons.attach_file_outlined,
              child: _DocumentsTab(
                state: state,
                notifier: notifier,
                approvalReferenceController: _approvalReferenceController,
                remarksController: _remarksController,
              ),
            ),
          ],
        ),
        formActions: BsFormActionBar(
          isLoading: state.saving,
          cancelButton: BsCancelButton(
            onPressed: () => _cancel(context, state.isDirty),
          ),
          actions: [
            BsActionButton(
              label: 'Validate',
              icon: Icons.check_circle_outline,
              onPressed: state.saving ? null : _onValidate,
            ),
            BsActionButton(
              label: 'Save & New',
              icon: Icons.save_as_outlined,
              onPressed: state.saving
                  ? null
                  : () => _saveAndNew(context, notifier),
            ),
          ],
          saveButton: BsSaveButton(
            onPressed: state.saving ? null : () => _save(context, notifier),
          ),
        ),
        isLoading: state.loading || state.saving,
        isDirty: state.isDirty,
        onSaveShortcut: state.saving ? null : () => _save(context, notifier),
        onCancelShortcut: () => _cancel(context, state.isDirty),
      ),
    );
  }

  Widget _buildBasicInfoSection({
    required FarAssetFormState state,
    required FarAssetFormController notifier,
    required String legalEntityName,
    required bool enabled,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            BsTextField(
              label: 'Asset Name',
              controller: _assetNameController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateAssetName,
            ),
            BsTextField(
              label: 'Description',
              controller: _descriptionController,
              enabled: enabled,
              onChanged: notifier.updateDescription,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'Asset Type',
              value: state.assetType,
              requiredField: true,
              items: _assetTypeOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateAssetType,
            ),
            BsTextField(
              label: 'Brand',
              controller: _brandController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateBrand,
            ),
            BsTextField(
              label: 'Model',
              controller: _modelController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateModel,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsTextField(
              label: 'Serial No',
              controller: _serialNumberController,
              requiredField: true,
              enabled: enabled,
              onChanged: notifier.updateSerialNumber,
            ),
            BsTextField(
              label: 'Quantity',
              controller: _quantityController,
              keyboardType: TextInputType.number,
              enabled: enabled,
              onChanged: (v) =>
                  notifier.updateField(quantity: double.tryParse(v)),
            ),
            BsDropdownField<String>(
              label: 'Unit',
              value: state.unit,
              items: _unitOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) => notifier.updateField(unit: v),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _openAddCostDialog() async {
    final costTypeController = ValueNotifier<String>('Transportation');
    final purchaseCostController = TextEditingController();
    final otherCostController = TextEditingController();
    final currencyController = ValueNotifier<String>('MMK');
    final costDateController = TextEditingController(
      text: _fmtDate(DateTime.now()),
    );
    final descriptionController = TextEditingController();

    final result = await showDialog<AdditionalCostItem>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add Additional Cost'),
        content: SizedBox(
          width: 500,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BsDropdownField<String>(
                label: 'Cost Type *',
                value: costTypeController.value,
                items: _costTypeOptions
                    .map(
                      (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                    )
                    .toList(),
                onChanged: (v) => costTypeController.value = v ?? '',
              ),
              const SizedBox(height: 12),
              BsTextField(
                label: 'Purchase Cost',
                controller: purchaseCostController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              BsTextField(
                label: 'Other Capitalizable Cost',
                controller: otherCostController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              ValueListenableBuilder(
                valueListenable: purchaseCostController,
                builder: (_, __, ___) {
                  return ValueListenableBuilder(
                    valueListenable: otherCostController,
                    builder: (_, __, ___) {
                      final total =
                          (double.tryParse(purchaseCostController.text) ?? 0) +
                          (double.tryParse(otherCostController.text) ?? 0);
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calculate, color: Colors.blue),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Text(
                                'Total Capitalizable Cost',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                            Text(
                              total.toStringAsFixed(2),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 12),
              BsDropdownField<String>(
                label: 'Currency',
                value: currencyController.value,
                items: _currencyOptions
                    .map(
                      (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                    )
                    .toList(),
                onChanged: (v) => currencyController.value = v ?? 'MMK',
              ),
              const SizedBox(height: 12),
              BsDateField(label: 'Cost Date', controller: costDateController),
              const SizedBox(height: 12),
              BsTextField(
                label: 'Description',
                controller: descriptionController,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop(
                AdditionalCostItem(
                  costType: costTypeController.value,
                  purchaseCost:
                      double.tryParse(purchaseCostController.text) ?? 0,
                  otherCapitalizableCost:
                      double.tryParse(otherCostController.text) ?? 0,
                  currency: currencyController.value,
                  description: descriptionController.text,
                  date: DateTime.tryParse(costDateController.text),
                ),
              );
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );

    if (result != null && mounted) {
      ref
          .read(farAssetFormControllerProvider(widget.assetId).notifier)
          .addAdditionalCostItem(result);
    }
  }

  void _checkDuplicate() {
    final name = _assetNameController.text.trim();
    if (name.isEmpty) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Enter Asset Name before checking duplicate.');
      return;
    }
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Duplicate check is ready for backend integration.');
  }

  void _onValidate() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    ref
        .read(bsFooterMessageProvider.notifier)
        .showSuccess('Validation passed. Asset is eligible.');
  }

  Future<void> _save(
    BuildContext context,
    FarAssetFormController notifier,
  ) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    await notifier.save();
    if (!context.mounted) return;
    if (notifier.state.error == null) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Asset saved successfully.');
      context.go('/far/assets');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showError('Save failed. Please try again.');
    }
  }

  Future<void> _saveAndNew(
    BuildContext context,
    FarAssetFormController notifier,
  ) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    await notifier.save();
    if (!context.mounted) return;
    if (notifier.state.error == null) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Asset saved. Ready for new entry.');
      context.go('/far/assets/new');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showError('Save failed. Please try again.');
    }
  }

  Future<void> _saveDraft(
    BuildContext context,
    FarAssetFormController notifier,
  ) async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showValidation('Please correct the highlighted fields.');
      return;
    }
    await notifier.saveDraft();
    if (!context.mounted) return;
    if (notifier.state.error == null) {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showSuccess('Asset draft saved successfully.');
      context.go('/far/assets');
    } else {
      ref
          .read(bsFooterMessageProvider.notifier)
          .showError('Save failed. Please try again.');
    }
  }

  Future<void> _openNew(BuildContext context, bool isDirty) async {
    final canLeave = await BsFormDirtyGuard.confirmDiscard(
      context,
      isDirty: isDirty,
    );
    if (canLeave && context.mounted) context.go('/far/assets/new');
  }

  Future<void> _cancel(BuildContext context, bool isDirty) async {
    final canLeave = await BsFormDirtyGuard.confirmDiscard(
      context,
      isDirty: isDirty,
    );
    if (canLeave && context.mounted) context.go('/far/assets');
  }

  static String _fmtDate(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$m/$day/${d.year}';
  }

  static String _fmtDateTime(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    final h = d.hour.toString().padLeft(2, '0');
    final min = d.minute.toString().padLeft(2, '0');
    return '$m/$day/${d.year} $h:$min';
  }
}

// ═══════════════════════════════════════════════════════════════
// TAB 1 — CLASSIFICATION
// ═══════════════════════════════════════════════════════════════
class _ClassificationTab extends StatelessWidget {
  const _ClassificationTab({
    required this.state,
    required this.notifier,
    required this.usefulLifeController,
    required this.residualValueController,
    required this.assetClassOptions,
    required this.assetCategoryOptions,
    required this.subCategoryOptions,
    required this.depreciationMethodOptions,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final TextEditingController usefulLifeController;
  final TextEditingController residualValueController;
  final List<String> assetClassOptions;
  final List<String> assetCategoryOptions;
  final List<String> subCategoryOptions;
  final List<String> depreciationMethodOptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'Asset Class',
              value: state.assetClass,
              requiredField: true,
              items: assetClassOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateAssetClass,
            ),
            BsDropdownField<String>(
              label: 'Asset Category',
              value: state.assetCategory,
              requiredField: true,
              items: assetCategoryOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateAssetCategory,
            ),
            BsDropdownField<String>(
              label: 'Sub-Category',
              value: state.subCategory,
              items: subCategoryOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateSubCategory,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'Depreciation Method',
              value: state.depreciationMethod,
              items: depreciationMethodOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: notifier.updateDepreciationMethod,
            ),
            BsTextField(
              label: 'Useful Life',
              keyboardType: TextInputType.number,
              controller: usefulLifeController,
              onChanged: (v) => notifier.updateUsefulLife(double.tryParse(v)),
            ),
            BsTextField(
              label: 'Residual Value',
              keyboardType: TextInputType.number,
              controller: residualValueController,
              onChanged: (v) =>
                  notifier.updateResidualValue(double.tryParse(v)),
            ),
          ],
        ),
      ],
    );
  }
}
class _LocationTab extends StatelessWidget {
  const _LocationTab({
    required this.state,
    required this.notifier,
    required this.organizationsAsync,
    required this.partnersAsync,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final AsyncValue<List<Map<String, dynamic>>> organizationsAsync;
  final AsyncValue<List<Map<String, dynamic>>> partnersAsync;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Company',
              value: state.company,
              onChanged: notifier.updateCompany,
            ),
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Branch',
              value: state.branch,
              onChanged: notifier.updateBranch,
            ),
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Department',
              value: state.department,
              onChanged: notifier.updateDepartment,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            _AsyncBackendDropdown(
              async: organizationsAsync,
              label: 'Location',
              value: state.location,
              onChanged: notifier.updateLocation,
            ),
            _AsyncBackendDropdown(
              async: partnersAsync,
              label: 'Custodian',
              value: state.custodian,
              onChanged: notifier.updateCustodian,
            ),
          ],
        ),
      ],
    );
  }
}

class _FinancialTab extends StatelessWidget {
  const _FinancialTab({
    required this.state,
    required this.notifier,
    required this.partnersAsync,
    required this.invoiceNoController,
    required this.purchaseCostController,
    required this.otherCostController,
    required this.currencyOptions,
    required this.accountOptions,
    required this.onAddCost,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final AsyncValue<List<Map<String, dynamic>>> partnersAsync;
  final TextEditingController invoiceNoController;
  final TextEditingController purchaseCostController;
  final TextEditingController otherCostController;
  final List<String> currencyOptions;
  final List<String> accountOptions;
  final VoidCallback onAddCost;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsTextField(
              label: 'Invoice No',
              controller: invoiceNoController,
              onChanged: notifier.updateInvoiceNo,
            ),
            _AsyncBackendDropdown(
              async: partnersAsync,
              label: 'Supplier',
              value: state.supplier,
              onChanged: notifier.updateSupplier,
            ),
            BsDateField(
              label: 'Acquisition Date',
              controller: TextEditingController(
                text: state.acquisitionDate == null
                    ? ''
                    : _fmt(state.acquisitionDate!),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        InkWell(
          onTap: onAddCost,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Add Cost (Click + to add cost)',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Icon(Icons.add_circle, color: Colors.blue.shade700),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (state.additionalCosts.isNotEmpty) ...[
          const Text(
            'Additional Costs',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...state.additionalCosts.asMap().entries.map((entry) {
            final idx = entry.key;
            final cost = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(
                  '${cost.costType} - ${cost.amount} ${cost.currency}',
                ),
                subtitle: Text('${cost.date ?? ''}  ${cost.description}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => notifier.removeAdditionalCostItem(idx),
                ),
              ),
            );
          }),
          const SizedBox(height: 12),
        ],
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 3,
          children: [
            BsDropdownField<String>(
              label: 'GL Asset Account',
              value: state.glAssetAccount?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) =>
                  notifier.updateGlAssetAccount(int.tryParse(v ?? '')),
            ),
            BsDropdownField<String>(
              label: 'Accum. Depreciation A/C',
              value: state.accumDepreciationAccount?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) => notifier.updateAccumDepreciationAccount(
                int.tryParse(v ?? ''),
              ),
            ),
            BsDropdownField<String>(
              label: 'Depreciation Expense A/C',
              value: state.depreciationExpenseAccount?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) => notifier.updateDepreciationExpenseAccount(
                int.tryParse(v ?? ''),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            BsDropdownField<String>(
              label: 'Cost Center',
              value: state.costCenter?.toString(),
              items: accountOptions
                  .map(
                    (v) => DropdownMenuItem<String>(value: v, child: Text(v)),
                  )
                  .toList(),
              onChanged: (v) =>
                  notifier.updateCostCenter(int.tryParse(v ?? '')),
            ),
            BsDateField(
              label: 'Capitalization Date',
              controller: TextEditingController(
                text: state.capDate == null ? '' : _fmt(state.capDate!),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static String _fmt(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
  }
}

class _DocumentsTab extends StatelessWidget {
  const _DocumentsTab({
    required this.state,
    required this.notifier,
    required this.approvalReferenceController,
    required this.remarksController,
  });

  final FarAssetFormState state;
  final FarAssetFormController notifier;
  final TextEditingController approvalReferenceController;
  final TextEditingController remarksController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 2,
          children: [
            _buildFileUploadField(
              context,
              label: 'Invoice Attachment',
              fileName: state.invoiceAttachment,
            ),
            _buildFileUploadField(
              context,
              label: 'PO Attachment',
              fileName: state.poAttachment,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 1,
          children: [
            BsTextField(
              label: 'Approval Reference',
              controller: approvalReferenceController,
              onChanged: notifier.updateApprovalReference,
            ),
          ],
        ),
        const SizedBox(height: 12),
        BsFormRow(
          fieldWidth: 260,
          maxColumns: 1,
          children: [
            BsTextField(
              label: 'Remarks',
              controller: remarksController,
              onChanged: notifier.updateRemarks,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFileUploadField(
    BuildContext context, {
    required String label,
    String? fileName,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  fileName ?? 'Upload File',
                  style: TextStyle(
                    color: fileName == null ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.upload_file),
                onPressed: () {
                  // TODO: Pick file
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AsyncBackendDropdown extends StatelessWidget {
  const _AsyncBackendDropdown({
    required this.async,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final AsyncValue<List<Map<String, dynamic>>> async;
  final String label;
  final int? value;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return async.when(
      loading: () => BsTextField(
        label: label,
        controller: TextEditingController(text: 'Loading...'),
        enabled: false,
      ),
      error: (e, _) => BsTextField(
        label: label,
        controller: TextEditingController(text: 'Error'),
        enabled: false,
      ),
      data: (items) {
        final mapped = items
            .map((item) {
              final id = int.tryParse(item['id']?.toString() ?? '');
              final name =
                  item['name']?.toString() ??
                  item['legal_entity_name']?.toString() ??
                  item['partner_name']?.toString() ??
                  item['display_name']?.toString() ??
                  item['title']?.toString() ??
                  'ID ${item['id']}';
              return DropdownMenuItem<int>(
                value: id,
                child: Text(name, overflow: TextOverflow.ellipsis),
              );
            })
            .where((item) => item.value != null)
            .toList();

        final selectedExists = mapped.any((item) => item.value == value);

        return BsDropdownField<int>(
          label: label,
          value: selectedExists ? value : null,
          items: mapped,
          onChanged: onChanged,
        );
      },
    );
  }
}
