// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:pluto_grid/pluto_grid.dart';

// import '../../../../../shared/layout/bs_page.dart';
// import '../../../../../shared/layout/bs_page_header.dart';
// import '../../../../../shared/navigation/bs_breadcrumb.dart';
// import '../../../../../shared/navigation/bs_breadcrumb_item.dart';
// import '../../../../../shared/buttons/bs_new_button.dart';
// import '../../../../../shared/buttons/bs_refresh_button.dart';
// import '../../../../../shared/grid/bs_pluto_grid.dart';
// import '../controller/far_asset_draft_list_controller.dart';
// import '../../domain/model/far_asset.dart';

// class FarAssetListPage extends ConsumerStatefulWidget {
//   const FarAssetListPage({super.key});

//   @override
//   ConsumerState<FarAssetListPage> createState() => _FarAssetListPageState();
// }

// class _FarAssetListPageState extends ConsumerState<FarAssetListPage> {
//   final TextEditingController _searchController = TextEditingController();

//   String? _selectedStatus;

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _refresh() async {
//     await ref.read(farAssetListControllerProvider.notifier).refresh();
//   }

//   List<FarAsset> _filterAssets(List<FarAsset> assets) {
//     final search = _searchController.text.trim().toLowerCase();

//     return assets.where((asset) {
//       final matchesSearch =
//           search.isEmpty ||
//           asset.assetName.toLowerCase().contains(search) ||
//           (asset.serial ?? '').toLowerCase().contains(search) ||
//           (asset.assetClass ?? '').toLowerCase().contains(search) ||
//           (asset.assetCategory ?? '').toLowerCase().contains(search);

//       final matchesStatus =
//           _selectedStatus == null ||
//           _selectedStatus!.isEmpty ||
//           asset.status == _selectedStatus;

//       return matchesSearch && matchesStatus;
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final assetState = ref.watch(farAssetListControllerProvider);

//     return BsPage(
//       title: 'Fixed Assets',
//       breadcrumb: BsBreadcrumb(
//         items: const [
//           BsBreadcrumbItem(label: 'Home'),
//           BsBreadcrumbItem(label: 'FAR'),
//           BsBreadcrumbItem(label: 'Fixed Assets'),
//         ],
//       ),
//       header: BsPageHeader(
//         title: 'Fixed Assets',
//         subtitle: 'Fixed Asset Register',
//         actions: [
//           BsNewButton(
//             onPressed: () {
//               context.go('/far/assets/new');
//             },
//           ),
//           BsRefreshButton(onPressed: _refresh),
//         ],
//       ),
//       body: assetState.when(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(error.toString()),
//               const SizedBox(height: 12),
//               ElevatedButton(onPressed: _refresh, child: const Text('Retry')),
//             ],
//           ),
//         ),
//         data: (assets) {
//           final filtered = _filterAssets(assets);

//           return Column(
//             children: [
//               _buildFilters(),
//               const SizedBox(height: 12),
//               Expanded(child: _buildGrid(filtered)),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFilters() {
//     return Row(
//       children: [
//         SizedBox(
//           width: 300,
//           child: TextField(
//             controller: _searchController,
//             onChanged: (_) => setState(() {}),
//             decoration: InputDecoration(
//               hintText: 'Search asset name, serial, category...',
//               prefixIcon: const Icon(Icons.search),
//               suffixIcon: _searchController.text.isNotEmpty
//                   ? IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         _searchController.clear();
//                         setState(() {});
//                       },
//                     )
//                   : null,
//             ),
//           ),
//         ),
//         const SizedBox(width: 16),
//         SizedBox(
//           width: 180,
//           child: DropdownButtonFormField<String?>(
//             value: _selectedStatus,
//             decoration: const InputDecoration(labelText: 'Status'),
//             items: const [
//               DropdownMenuItem(value: null, child: Text('All')),
//               DropdownMenuItem(value: 'Draft', child: Text('Draft')),
//               DropdownMenuItem(value: 'Posted', child: Text('Posted')),
//               DropdownMenuItem(value: 'Active', child: Text('Active')),
//               DropdownMenuItem(value: 'Disposed', child: Text('Disposed')),
//             ],
//             onChanged: (value) {
//               setState(() {
//                 _selectedStatus = value;
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildGrid(List<FarAsset> assets) {
//     final columns = <PlutoColumn>[
//       PlutoColumn(
//         title: 'ID',
//         field: 'id',
//         type: PlutoColumnType.number(),
//         hide: true,
//       ),
//       PlutoColumn(
//         title: 'Asset Name',
//         field: 'assetName',
//         type: PlutoColumnType.text(),
//         width: 220,
//       ),
//       PlutoColumn(
//         title: 'Asset Class',
//         field: 'assetClass',
//         type: PlutoColumnType.text(),
//         width: 160,
//       ),
//       PlutoColumn(
//         title: 'Category',
//         field: 'assetCategory',
//         type: PlutoColumnType.text(),
//         width: 160,
//       ),
//       PlutoColumn(
//         title: 'Brand',
//         field: 'brand',
//         type: PlutoColumnType.text(),
//         width: 120,
//       ),
//       PlutoColumn(
//         title: 'Model',
//         field: 'model',
//         type: PlutoColumnType.text(),
//         width: 130,
//       ),
//       PlutoColumn(
//         title: 'Serial',
//         field: 'serial',
//         type: PlutoColumnType.text(),
//         width: 150,
//       ),
//       PlutoColumn(
//         title: 'Acquisition Date',
//         field: 'acquisitionDate',
//         type: PlutoColumnType.text(),
//         width: 150,
//       ),
//       PlutoColumn(
//         title: 'Cost',
//         field: 'purchaseCost',
//         type: PlutoColumnType.number(),
//         width: 130,
//       ),
//       PlutoColumn(
//         title: 'Currency',
//         field: 'currency',
//         type: PlutoColumnType.text(),
//         width: 100,
//       ),
//       PlutoColumn(
//         title: 'Status',
//         field: 'status',
//         type: PlutoColumnType.text(),
//         width: 120,
//       ),
//       PlutoColumn(
//         title: 'Action',
//         field: 'action',
//         type: PlutoColumnType.text(),
//         width: 130,
//         enableSorting: false,
//         enableFilterMenuItem: false,
//       ),
//     ];

//     final rows = assets.map((asset) {
//       return PlutoRow(
//         cells: {
//           'id': PlutoCell(value: asset.id),
//           'assetName': PlutoCell(value: asset.assetName),
//           'assetClass': PlutoCell(value: asset.assetClass ?? ''),
//           'assetCategory': PlutoCell(value: asset.assetCategory ?? ''),
//           'brand': PlutoCell(value: asset.brand ?? ''),
//           'model': PlutoCell(value: asset.model ?? ''),
//           'serial': PlutoCell(value: asset.serial ?? ''),
//           'acquisitionDate': PlutoCell(
//             value: _formatDate(asset.acquisitionDate),
//           ),
//           'purchaseCost': PlutoCell(value: asset.purchaseCost ?? 0),
//           'currency': PlutoCell(value: asset.currency ?? ''),
//           'status': PlutoCell(value: asset.status ?? 'Draft'),
//           'action': PlutoCell(value: ''),
//         },
//       );
//     }).toList();

//     return BsPlutoGrid(columns: columns, rows: rows);
//   }

//   String _formatDate(DateTime? date) {
//     if (date == null) return '';
//     return '${date.day.toString().padLeft(2, '0')}/'
//         '${date.month.toString().padLeft(2, '0')}/'
//         '${date.year}';
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../../../../../shared/layout/bs_page.dart';
import '../../../../../shared/layout/bs_page_header.dart';
import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';
import '../../../../../shared/buttons/bs_new_button.dart';
import '../../../../../shared/buttons/bs_refresh_button.dart';
import '../../../../../shared/buttons/bs_action_button.dart';
import '../../../../../shared/grid/bs_pluto_grid.dart';
import '../../../../../shared/inputs/bs_text_field.dart';
import '../../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../../shared/inputs/bs_date_field.dart';
import '../../../../../shared/layout/bs_form_row.dart';
import '../../../../../core/footer/bs_footer_message_provider.dart';

import '../controller/far_asset_draft_list_controller.dart';
import '../controller/far_asset_dropdown_provider.dart';
import '../../domain/model/far_asset.dart';

class FarAssetListPage extends ConsumerStatefulWidget {
  const FarAssetListPage({super.key});

  @override
  ConsumerState<FarAssetListPage> createState() => _FarAssetListPageState();
}

class _FarAssetListPageState extends ConsumerState<FarAssetListPage> {
  // ─── Filter Controllers ───
  final _keywordController = TextEditingController();
  final _supplierController = TextEditingController();

  DateTime? _draftDateFrom;
  DateTime? _draftDateTo;

  String? _assetClass;
  String? _category;
  String? _source;
  String? _validationStatus;
  int? _branch;
  int? _department;
  int? _supplier;

  @override
  void dispose() {
    _keywordController.dispose();
    _supplierController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await ref.read(farAssetListControllerProvider.notifier).refresh();
  }

  List<FarAsset> _filterAssets(List<FarAsset> assets) {
    final keyword = _keywordController.text.trim().toLowerCase();

    return assets.where((asset) {
      // Draft Date From
      if (_draftDateFrom != null &&
          (asset.draftDate == null ||
              asset.draftDate!.isBefore(_draftDateFrom!))) {
        return false;
      }
      // Draft Date To
      if (_draftDateTo != null &&
          (asset.draftDate == null ||
              asset.draftDate!.isAfter(_draftDateTo!))) {
        return false;
      }
      // Asset Class
      if (_assetClass != null &&
          _assetClass!.isNotEmpty &&
          asset.assetClass != _assetClass) {
        return false;
      }
      // Category
      if (_category != null &&
          _category!.isNotEmpty &&
          asset.assetCategory != _category) {
        return false;
      }
      // Source
      if (_source != null && _source!.isNotEmpty && asset.source != _source) {
        return false;
      }
      // Validation Status
      if (_validationStatus != null &&
          _validationStatus!.isNotEmpty &&
          asset.status != _validationStatus) {
        return false;
      }
      // Branch
      if (_branch != null && asset.branch != _branch) {
        return false;
      }
      // Department
      if (_department != null && asset.department != _department) {
        return false;
      }
      // Supplier
      if (_supplier != null && asset.supplier != _supplier) {
        return false;
      }
      // Keyword
      if (keyword.isNotEmpty) {
        final matchesKeyword =
            asset.assetName.toLowerCase().contains(keyword) ||
            (asset.serial ?? '').toLowerCase().contains(keyword) ||
            (asset.assetClass ?? '').toLowerCase().contains(keyword) ||
            (asset.assetCategory ?? '').toLowerCase().contains(keyword) ||
            (asset.draftNo ?? '').toLowerCase().contains(keyword);
        if (!matchesKeyword) return false;
      }
      return true;
    }).toList();
  }

  void _onSearch() {
    setState(() {});
  }

  void _onReset() {
    setState(() {
      _draftDateFrom = null;
      _draftDateTo = null;
      _assetClass = null;
      _category = null;
      _source = null;
      _validationStatus = null;
      _branch = null;
      _department = null;
      _supplier = null;
      _keywordController.clear();
      _supplierController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetState = ref.watch(farAssetListControllerProvider);

    final organizationsAsync = ref.watch(organizationsProvider);
    final partnersAsync = ref.watch(partnersProvider);

    return BsPage(
      title: 'Draft Asset List',
      breadcrumb: BsBreadcrumb(
        items: const [
          BsBreadcrumbItem(label: 'Home'),
          BsBreadcrumbItem(label: 'Fixed Assets Register'),
          BsBreadcrumbItem(label: 'Draft Asset List'),
        ],
      ),
      header: BsPageHeader(
        title: 'Draft Asset List',
        subtitle: 'Fixed Assets Register',
        actions: [
          BsNewButton(
            onPressed: () {
              context.go('/far/assets/new');
            },
          ),
          BsRefreshButton(onPressed: _refresh),
        ],
      ),
      body: assetState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(error.toString()),
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _refresh, child: const Text('Retry')),
            ],
          ),
        ),
        data: (assets) {
          final filtered = _filterAssets(assets);

          return Column(
            children: [
              // ─── Filter Panel ───
              _buildFilterPanel(
                organizationsAsync: organizationsAsync,
                partnersAsync: partnersAsync,
              ),
              const SizedBox(height: 12),

              // ─── Toolbar ───
              _buildToolbar(),
              const SizedBox(height: 12),

              // ─── List Grid ───
              Expanded(child: _buildGrid(filtered)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilterPanel({
    required AsyncValue<List<Map<String, dynamic>>> organizationsAsync,
    required AsyncValue<List<Map<String, dynamic>>> partnersAsync,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Row 1: Draft Date From / To
            BsFormRow(
              fieldWidth: 260,
              maxColumns: 2,
              children: [
                BsDateField(
                  label: 'Draft Date From',
                  controller: TextEditingController(
                    text: _draftDateFrom == null
                        ? ''
                        : _fmtDate(_draftDateFrom!),
                  ),
                  onChanged: (d) => setState(() => _draftDateFrom = d),
                ),
                BsDateField(
                  label: 'Draft Date To',
                  controller: TextEditingController(
                    text: _draftDateTo == null ? '' : _fmtDate(_draftDateTo!),
                  ),
                  onChanged: (d) => setState(() => _draftDateTo = d),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 2: Asset Class, Category, Source, Validation Status
            BsFormRow(
              fieldWidth: 260,
              maxColumns: 4,
              children: [
                BsDropdownField<String>(
                  label: 'Asset Class',
                  value: _assetClass,
                  items: const [
                    DropdownMenuItem(
                      value: 'IT Equipment',
                      child: Text('IT Equipment'),
                    ),
                    DropdownMenuItem(
                      value: 'Office Equipment',
                      child: Text('Office Equipment'),
                    ),
                    DropdownMenuItem(
                      value: 'Furniture',
                      child: Text('Furniture'),
                    ),
                    DropdownMenuItem(value: 'Vehicle', child: Text('Vehicle')),
                  ],
                  onChanged: (v) => setState(() => _assetClass = v),
                ),
                BsDropdownField<String>(
                  label: 'Category',
                  value: _category,
                  items: const [
                    DropdownMenuItem(value: 'Laptop', child: Text('Laptop')),
                    DropdownMenuItem(value: 'Desktop', child: Text('Desktop')),
                    DropdownMenuItem(value: 'Printer', child: Text('Printer')),
                    DropdownMenuItem(value: 'Aircon', child: Text('Aircon')),
                  ],
                  onChanged: (v) => setState(() => _category = v),
                ),
                BsDropdownField<String>(
                  label: 'Source',
                  value: _source,
                  items: const [
                    DropdownMenuItem(value: 'Manual', child: Text('Manual')),
                    DropdownMenuItem(value: 'Import', child: Text('Import')),
                    DropdownMenuItem(value: 'WIP', child: Text('WIP')),
                  ],
                  onChanged: (v) => setState(() => _source = v),
                ),
                BsDropdownField<String>(
                  label: 'Validation Status',
                  value: _validationStatus,
                  items: const [
                    DropdownMenuItem(
                      value: 'Complete',
                      child: Text('Complete'),
                    ),
                    DropdownMenuItem(
                      value: 'Incomplete',
                      child: Text('Incomplete'),
                    ),
                  ],
                  onChanged: (v) => setState(() => _validationStatus = v),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 3: Branch, Department, Supplier, Keyword
            BsFormRow(
              fieldWidth: 260,
              maxColumns: 4,
              children: [
                _AsyncBackendDropdown(
                  async: organizationsAsync,
                  label: 'Branch',
                  value: _branch,
                  onChanged: (v) => setState(() => _branch = v),
                ),
                _AsyncBackendDropdown(
                  async: organizationsAsync,
                  label: 'Department',
                  value: _department,
                  onChanged: (v) => setState(() => _department = v),
                ),
                _AsyncBackendDropdown(
                  async: partnersAsync,
                  label: 'Supplier',
                  value: _supplier,
                  onChanged: (v) => setState(() => _supplier = v),
                ),
                BsTextField(
                  label: 'Keyword Search',
                  controller: _keywordController,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Row 4: Search / Reset
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BsActionButton(
                  label: 'Search',
                  icon: Icons.search,
                  onPressed: _onSearch,
                ),
                const SizedBox(width: 8),
                BsActionButton(
                  label: 'Reset',
                  icon: Icons.refresh,
                  onPressed: _onReset,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToolbar() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        BsActionButton(
          label: 'Import Excel/CSV',
          icon: Icons.upload_file,
          onPressed: _onImport,
        ),
        BsActionButton(
          label: 'Transfer from WIP',
          icon: Icons.swap_horiz,
          onPressed: _onTransferFromWip,
        ),
        BsActionButton(
          label: 'Bulk Validate',
          icon: Icons.rule,
          onPressed: _onBulkValidate,
        ),
        BsActionButton(
          label: 'Bulk Print Approval',
          icon: Icons.print,
          onPressed: _onBulkPrint,
        ),
        BsActionButton(
          label: 'Bulk Capitalize',
          icon: Icons.attach_money,
          onPressed: _onBulkCapitalize,
        ),
        BsActionButton(
          label: 'Export',
          icon: Icons.download,
          onPressed: _onExport,
        ),
      ],
    );
  }
  Widget _buildGrid(List<FarAsset> assets) {
    final columns = <PlutoColumn>[
      PlutoColumn(
        title: 'ID',
        field: 'id',
        type: PlutoColumnType.number(),
        hide: true,
      ),
      PlutoColumn(
        title: 'Draft No',
        field: 'draftNo',
        type: PlutoColumnType.text(),
        width: 140,
      ),
      PlutoColumn(
        title: 'Asset Name',
        field: 'assetName',
        type: PlutoColumnType.text(),
        width: 200,
      ),
      PlutoColumn(
        title: 'Class',
        field: 'assetClass',
        type: PlutoColumnType.text(),
        width: 140,
      ),
      PlutoColumn(
        title: 'Category',
        field: 'assetCategory',
        type: PlutoColumnType.text(),
        width: 140,
      ),
      PlutoColumn(
        title: 'Source',
        field: 'source',
        type: PlutoColumnType.text(),
        width: 100,
      ),
      PlutoColumn(
        title: 'Draft Date',
        field: 'draftDate',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Supplier',
        field: 'supplier',
        type: PlutoColumnType.text(),
        width: 150,
      ),
      PlutoColumn(
        title: 'Cost',
        field: 'purchaseCost',
        type: PlutoColumnType.number(),
        width: 130,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        width: 110,
      ),
      PlutoColumn(
        title: 'Eligibility',
        field: 'eligibility',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'action',
        type: PlutoColumnType.text(),
        width: 260,
        enableSorting: false,
        enableFilterMenuItem: false,
        renderer: (rendererContext) {
          final asset = assets.firstWhere(
            (a) => a.id == rendererContext.row.cells['id']!.value,
          );
          return Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility, size: 18),
                tooltip: 'View',
                onPressed: () => _onView(asset),
              ),
              IconButton(
                icon: const Icon(Icons.edit, size: 18),
                tooltip: 'Edit',
                onPressed: () => _onEdit(asset),
              ),
              IconButton(
                icon: const Icon(Icons.print, size: 18),
                tooltip: 'Print',
                onPressed: () => _onPrint(asset),
              ),
              if ((asset.status ?? '') == 'Complete')
                IconButton(
                  icon: const Icon(Icons.attach_money, size: 18),
                  tooltip: 'Capitalize',
                  onPressed: () => _onCapitalize(asset),
                ),
              IconButton(
                icon: const Icon(Icons.delete, size: 18),
                tooltip: 'Delete',
                onPressed: () => _onDelete(asset),
              ),
            ],
          );
        },
      ),
    ];

    final rows = assets.map((asset) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: asset.id),
          'draftNo': PlutoCell(value: asset.draftNo ?? ''),
          'assetName': PlutoCell(value: asset.assetName),
          'assetClass': PlutoCell(value: asset.assetClass ?? ''),
          'assetCategory': PlutoCell(value: asset.assetCategory ?? ''),
          'source': PlutoCell(value: asset.source ?? ''),
          'draftDate': PlutoCell(value: _formatDate(asset.draftDate)),
          'supplier': PlutoCell(value: asset.supplier?.toString() ?? ''),
          'purchaseCost': PlutoCell(value: asset.purchaseCost ?? 0),
          'status': PlutoCell(value: asset.status ?? 'Draft'),
          'eligibility': PlutoCell(
            value: (asset.status ?? '') == 'Complete'
                ? 'Eligible'
                : 'Not Eligible',
          ),
          'action': PlutoCell(value: ''),
        },
      );
    }).toList();

    return BsPlutoGrid(columns: columns, rows: rows);
  }

  void _onImport() {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Import Excel/CSV is not yet implemented.');
  }

  void _onTransferFromWip() {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Transfer from WIP is not yet implemented.');
  }

  void _onBulkValidate() {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Bulk Validate is not yet implemented.');
  }

  void _onBulkPrint() {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Bulk Print Approval is not yet implemented.');
  }

  void _onBulkCapitalize() {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Bulk Capitalize is not yet implemented.');
  }

  void _onExport() {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Export is not yet implemented.');
  }

  void _onView(FarAsset asset) {
    context.go('/far/assets/${asset.id}/view');
  }

  void _onEdit(FarAsset asset) {
    context.go('/far/assets/${asset.id}/edit');
  }

  void _onPrint(FarAsset asset) {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Print for ${asset.draftNo} is not yet implemented.');
  }

  void _onCapitalize(FarAsset asset) {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Capitalize for ${asset.draftNo} is not yet implemented.');
  }

  void _onDelete(FarAsset asset) {
    ref
        .read(bsFooterMessageProvider.notifier)
        .showInfo('Delete for ${asset.draftNo} is not yet implemented.');
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  static String _fmtDate(DateTime d) {
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '${d.year}-$m-$day';
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
                  item['partner_name']?.toString() ??
                  item['display_name']?.toString() ??
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
