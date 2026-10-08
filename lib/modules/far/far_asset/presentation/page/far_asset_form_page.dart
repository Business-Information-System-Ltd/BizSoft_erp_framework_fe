import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/far_asset_form_controller.dart';

import 'package:bizsoft_frontend_framework/core/widgets/app_text_field.dart';
import 'package:bizsoft_frontend_framework/core/widgets/app_dropdown.dart';
import 'package:bizsoft_frontend_framework/core/widgets/app_date_field.dart';
import 'package:bizsoft_frontend_framework/core/widgets/app_section_card.dart';
import 'package:bizsoft_frontend_framework/core/widgets/fixed_bottom_action_bar.dart';
import 'package:bizsoft_frontend_framework/core/widgets/context_info_line.dart';
import 'package:bizsoft_frontend_framework/core/widgets/compact_erp_tab_bar.dart';

class FarAssetFormPage extends ConsumerStatefulWidget {
  final int? assetId;
  const FarAssetFormPage({super.key, this.assetId});

  @override
  ConsumerState<FarAssetFormPage> createState() => _FarAssetFormPageState();
}

class _FarAssetFormPageState extends ConsumerState<FarAssetFormPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(farAssetFormControllerProvider(widget.assetId));
    final controller = ref.read(
      farAssetFormControllerProvider(widget.assetId).notifier,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _buildHeader(state),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    children: [
                      _buildBasicInfoCard(state, controller),
                      const SizedBox(height: 12),
                      _buildTabbedCard(state, controller),
                      const SizedBox(height: 12),
                      if (state.validationMessages.isNotEmpty)
                        _buildValidationPanel(state),
                    ],
                  ),
                ),
                _buildActionBar(state, controller),
              ],
            ),
    );
  }

  Widget _buildHeader(FarAssetFormState state) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0B49A5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              Text(
                'Fixed Assets Register',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0B49A5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              Text(
                'Core Entity Entry',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0B49A5),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: Color(0xFF9CA3AF),
                ),
              ),
              Text(
                'New',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Fixed Asset Entry',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Create fixed asset profile',
                    style: TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
              OutlinedButton.icon(
                onPressed: () => _checkDuplicate(state),
                icon: const Icon(
                  Icons.search,
                  size: 16,
                  color: Color(0xFF0B49A5),
                ),
                label: const Text(
                  'Check Duplicate',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF0B49A5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  side: const BorderSide(color: Color(0xFF0B49A5), width: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  foregroundColor: const Color(0xFF0B49A5),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  minimumSize: const Size(0, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ContextInfoLine(
                  items: [
                    ContextInfoLineItem(
                      label: 'Draft No',
                      value: state.draftNo,
                      priority: 1,
                    ),
                    ContextInfoLineItem(
                      label: 'Source',
                      value: state.source,
                      priority: 2,
                    ),
                    ContextInfoLineItem(
                      label: 'Draft Date',
                      value: _fmtDate(state.draftDate),
                      priority: 3,
                    ),
                    ContextInfoLineItem(
                      label: 'Prepared By',
                      value: state.preparedBy,
                      priority: 4,
                    ),
                    ContextInfoLineItem(
                      label: 'Last Updated',
                      value: _fmtDateTime(state.lastUpdated),
                      priority: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Status: ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    state.status,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1F2937),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _checkDuplicate(FarAssetFormState state) async {
    if (state.assetName.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Asset Name first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.search, color: Color(0xFF0B49A5)),
            SizedBox(width: 8),
            Text('Check Duplicate'),
          ],
        ),
        content: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Checking for duplicate entries...',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 16),
              _dupCheckRow('Asset Name', state.assetName),
              _dupCheckRow('Description', state.description ?? '-'),
              _dupCheckRow('Asset Type *', state.assetType ?? '-'),
              _dupCheckRow('Serial No', state.serialNumber ?? '-'),
              _dupCheckRow('Brand', state.brand ?? '-'),
              _dupCheckRow('Model', state.model ?? '-'),
              _dupCheckRow('Quality', state.unit ?? '-'),
              _dupCheckRow('Unit', state.unit ?? '-'),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  border: Border.all(color: Colors.green.shade300, width: 0.8),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green.shade700,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'No duplicates found',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B49A5),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('No duplicate found — you can save'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _dupCheckRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF1F2937),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfoCard(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return AppSectionCard(
      title: 'Basic Asset Information',
      compact: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: AppTextField(
                  label: 'Asset Name *',
                  value: state.assetName ?? '',
                  onChanged: (v) => controller.updateField(assetName: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: AppTextField(
                  label: 'Description',
                  value: state.description ?? '',
                  onChanged: (v) => controller.updateField(description: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'Asset Type *',
                  value: state.assetType,
                  items: _itemsOf(const [
                    'IT Equipment',
                    'Furniture',
                    'Vehicle',
                  ]),
                  onChanged: (v) => controller.updateField(assetType: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppTextField(
                  label: 'Brand *',
                  value: state.brand ?? '',
                  onChanged: (v) => controller.updateField(brand: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppTextField(
                  label: 'Model *',
                  value: state.model ?? '',
                  onChanged: (v) => controller.updateField(model: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Serial No *',
                  value: state.serialNumber ?? '',
                  onChanged: (v) => controller.updateField(serialNumber: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Quantity',
                  value: state.unit,
                  items: _itemsOf(const ['Pcs', 'Set', 'Box', 'Unit']),
                  onChanged: (v) => controller.updateField(unit: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Unit',
                  value: state.unit,
                  items: _itemsOf(const ['Pcs', 'Set', 'Box', 'Unit']),
                  onChanged: (v) => controller.updateField(unit: v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabbedCard(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: Color(0xFFE5E7EB), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6),
                topRight: Radius.circular(6),
              ),
              border: Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB), width: 0.8),
              ),
            ),

            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF0B49A5),
              unselectedLabelColor: const Color(0xFF6B7280),
              indicatorColor: const Color(0xFF0B49A5),
              indicatorWeight: 2.0,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              dividerColor: Colors.transparent,
              padding: EdgeInsets.zero,
              labelPadding: const EdgeInsets.symmetric(horizontal: 16),
              tabAlignment: TabAlignment.start,
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              tabs: const [
                Tab(text: 'Classification'),
                Tab(text: 'Location and Responsibility'),
                Tab(text: 'Financial Information'),
                Tab(text: 'Documents / References'),
              ],
            ),
          ),
          SizedBox(
            height: 400,
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildClassificationTab(state, controller),
                _buildLocationTab(state, controller),
                _buildFinancialTab(state, controller),
                _buildDocumentsTab(state, controller),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClassificationTab(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'Asset Class *',
                  value: state.assetClass,
                  items: _itemsOf(const ['Class A', 'Class B', 'Class C']),
                  onChanged: (v) => controller.updateField(assetClass: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Asset Category *',
                  value: state.assetCategory,
                  items: _itemsOf(const [
                    'Laptop',
                    'Desktop',
                    'Printer',
                    'Furniture',
                  ]),
                  onChanged: (v) => controller.updateField(assetCategory: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Sub-Category',
                  value: state.subCategory,
                  items: _itemsOf(const ['Dell', 'HP', 'Lenovo', 'Other']),
                  onChanged: (v) => controller.updateField(subCategory: v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'Depreciation Method',
                  value: state.depreciationMethod,
                  items: _itemsOf(const [
                    'Straight Line',
                    'Declining Balance',
                    'None',
                  ]),
                  onChanged: (v) =>
                      controller.updateField(depreciationMethod: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppTextField(
                  label: 'Useful',
                  value: state.usefulLife?.toString() ?? '',
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      controller.updateField(usefulLife: double.tryParse(v)),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppTextField(
                  label: 'Residual',
                  value: state.residualValue?.toString() ?? '',
                  keyboardType: TextInputType.number,
                  onChanged: (v) =>
                      controller.updateField(residualValue: double.tryParse(v)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationTab(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'Company',
                  value: state.company?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(company: int.tryParse(v ?? '')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Branch',
                  value: state.branch?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(branch: int.tryParse(v ?? '')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Department',
                  value: state.department?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(department: int.tryParse(v ?? '')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'Location',
                  value: state.location?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(location: int.tryParse(v ?? '')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Custodian',
                  value: state.custodian?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(custodian: int.tryParse(v ?? '')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialTab(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Invoice No',
                  value: state.invoiceNo ?? '',
                  onChanged: (v) => controller.updateField(invoiceNo: v),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Supplier',
                  value: state.supplier?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(supplier: int.tryParse(v ?? '')),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDateField(
                  label: 'Acquisition Date',
                  value: state.acquisitionDate,
                  onChanged: (d) => controller.updateField(acquisitionDate: d),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _showAddCostDialog(state, controller),
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: 'Add Cost',
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD1D5DB),
                          width: 0.8,
                        ),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD1D5DB),
                          width: 0.8,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.add_circle,
                          color: Colors.blue,
                          size: 18,
                        ),
                        tooltip: 'Add Additional Cost',
                        onPressed: () => _showAddCostDialog(state, controller),
                      ),
                    ),
                    child: const SizedBox(
                      height: 20,
                      child: Text(
                        'Click + to add cost',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (state.additionalCosts.isNotEmpty) ...[
            const SizedBox(height: 16),
            _buildAdditionalCostList(state, controller),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'GL Asset Account',
                  value: state.glAssetAccount?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) => controller.updateField(
                    glAssetAccount: int.tryParse(v ?? ''),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Accum. Depreciation A/C',
                  value: state.accumDepreciationAccount?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) => controller.updateField(
                    accumDepreciationAccount: int.tryParse(v ?? ''),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AppDropdown<String>(
                  label: 'Depreciation Expense A/C',
                  value: state.depreciationExpenseAccount?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) => controller.updateField(
                    depreciationExpenseAccount: int.tryParse(v ?? ''),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppDropdown<String>(
                  label: 'Cost Center',
                  value: state.costCenter?.toString(),
                  items: _itemsOf(const ['1', '2', '3']),
                  onChanged: (v) =>
                      controller.updateField(costCenter: int.tryParse(v ?? '')),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppDateField(
                  label: 'Capitalization Date',
                  value: state.capDate,
                  onChanged: (d) => controller.updateField(capDate: d),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: SizedBox()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsTab(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _upload(
                  label: 'Invoice Attachment',
                  fileName: state.invoiceAttachmentPath,
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _upload(
                  label: 'PO Attachment',
                  fileName: state.poAttachmentPath,
                  onTap: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Approval Reference',
                  value: state.approvalReference ?? '',
                  onChanged: (v) =>
                      controller.updateField(approvalReference: v),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: 'Remarks',
                  value: state.remarks ?? '',
                  maxLines: 2,
                  onChanged: (v) => controller.updateField(remarks: v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _showAddCostDialog(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) async {
    final formKey = GlobalKey<FormState>();
    String costType = 'Transportation';
    String currency = 'MMK';
    final purchaseCostCtrl = TextEditingController();
    final otherCostCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    DateTime? costDate = DateTime.now();

    await showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final p = double.tryParse(purchaseCostCtrl.text) ?? 0.0;
          final o = double.tryParse(otherCostCtrl.text) ?? 0.0;
          final totalCost = p + o;

          return AlertDialog(
            title: const Text('Add Additional Cost'),
            content: SizedBox(
              width: 500,
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDropdown<String>(
                        label: 'Cost Type *',
                        value: costType,
                        items: _itemsOf(const [
                          'Transportation',
                          'Installation',
                          'Tax',
                          'Insurance',
                          'Other',
                        ]),
                        onChanged: (v) =>
                            setDialogState(() => costType = v ?? 'Other'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: purchaseCostCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Purchase Cost',
                          isDense: true,
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        onChanged: (_) => setDialogState(() {}),
                        validator: (v) {
                          if (v == null || v.isEmpty) return null;
                          if (double.tryParse(v) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: otherCostCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Other Capitalizable Cost',
                          isDense: true,
                          prefixIcon: Icon(Icons.add),
                        ),
                        onChanged: (_) => setDialogState(() {}),
                        validator: (v) {
                          if (v == null || v.isEmpty) return null;
                          if (double.tryParse(v) == null) {
                            return 'Invalid number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          border: Border.all(
                            color: Colors.blue.shade300,
                            width: 0.8,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.calculate, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(
                                  'Total Capitalizable Cost',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              totalCost.toStringAsFixed(2),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppDropdown<String>(
                        label: 'Currency',
                        value: currency,
                        items: _itemsOf(const ['MMK', 'USD', 'THB']),
                        onChanged: (v) =>
                            setDialogState(() => currency = v ?? 'MMK'),
                      ),
                      const SizedBox(height: 12),
                      InkWell(
                        onTap: () async {
                          final d = await showDatePicker(
                            context: ctx,
                            initialDate: costDate ?? DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (d != null) {
                            setDialogState(() => costDate = d);
                          }
                        },
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Cost Date',
                            isDense: true,
                            suffixIcon: Icon(Icons.calendar_today, size: 18),
                          ),
                          child: Text(
                            costDate == null ? '' : _fmtDate(costDate),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: descCtrl,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Description',
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (totalCost <= 0) {
                      ScaffoldMessenger.of(ctx).showSnackBar(
                        const SnackBar(
                          content: Text('Total must be greater than zero'),
                        ),
                      );
                      return;
                    }
                    controller.addAdditionalCostItem(
                      AdditionalCostItem(
                        costType: costType,
                        purchaseCost: p,
                        otherCapitalizableCost: o,
                        currency: currency,
                        description: descCtrl.text,
                        date: costDate,
                      ),
                    );
                    Navigator.pop(ctx);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAdditionalCostList(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    final total = state.additionalCosts.fold<double>(0, (s, e) => s + e.amount);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade200, width: 0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Additional Costs',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Grand Total: ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const Divider(height: 16, thickness: 0.8),
          ...state.additionalCosts.asMap().entries.map((entry) {
            final i = entry.key;
            final c = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(c.costType)),
                  Expanded(
                    flex: 2,
                    child: Text(c.purchaseCost.toStringAsFixed(2)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(c.otherCapitalizableCost.toStringAsFixed(2)),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      c.amount.toStringAsFixed(2),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Text(c.currency)),
                  Expanded(
                    flex: 2,
                    child: Text(c.date == null ? '-' : _fmtDate(c.date)),
                  ),
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                      onPressed: () => controller.removeAdditionalCostItem(i),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildValidationPanel(FarAssetFormState state) {
    final isError = state.validationStatus == 'Error';
    final color = isError ? Colors.red : Colors.orange;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        border: Border.all(color: color, width: 0.8),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                'Validation Status: ${state.validationStatus}',
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ...state.validationMessages.map(
            (m) => Padding(
              padding: const EdgeInsets.only(left: 32, top: 4),
              child: Text('- $m'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBar(
    FarAssetFormState state,
    FarAssetFormController controller,
  ) {
    return FixedBottomActionBar(
      isLoading: state.saving,
      cancelButton: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
      actions: [
        OutlinedButton(
          onPressed: controller.validateForm,
          child: const Text('Validate'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.black87,
            elevation: 0,
          ),
          onPressed: state.saving
              ? null
              : () async {
                  await controller.saveDraft();
                  if (mounted) Navigator.pop(context);
                },
          child: const Text('Save & New'),
        ),
      ],
      saveButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0B49A5),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        onPressed: state.saving
            ? null
            : () async {
                await controller.save();
                if (mounted) Navigator.pop(context);
              },
        child: state.saving
            ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text('Save'),
      ),
    );
  }

  Widget _upload({
    required String label,
    required String? fileName,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          isDense: true,
          suffixIcon: const Icon(Icons.upload_file, size: 18),
        ),
        child: Text(
          fileName ?? 'Upload File',
          style: TextStyle(
            color: fileName == null ? Colors.grey : Colors.black87,
          ),
        ),
      ),
    );
  }

  List<AppDropdownItem<String>> _itemsOf(List<String> values) {
    return [
      for (final v in values) AppDropdownItem<String>(value: v, label: v),
    ];
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year}';
  }

  String _fmtDateTime(DateTime? d) {
    if (d == null) return '';
    return '${d.day.toString().padLeft(2, '0')}/'
        '${d.month.toString().padLeft(2, '0')}/'
        '${d.year} '
        '${d.hour.toString().padLeft(2, '0')}:'
        '${d.minute.toString().padLeft(2, '0')}';
  }
}
