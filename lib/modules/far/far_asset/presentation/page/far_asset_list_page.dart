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
import '../../../../../shared/grid/bs_pluto_grid.dart';

import '../controller/far_asset_draft_list_controller.dart';
import '../../domain/model/far_asset.dart';

class FarAssetListPage extends ConsumerStatefulWidget {
  const FarAssetListPage({super.key});

  @override
  ConsumerState<FarAssetListPage> createState() => _FarAssetListPageState();
}

class _FarAssetListPageState extends ConsumerState<FarAssetListPage> {
  final TextEditingController _searchController = TextEditingController();

  String? _selectedStatus;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await ref.read(farAssetListControllerProvider.notifier).refresh();
  }

  List<FarAsset> _filterAssets(List<FarAsset> assets) {
    final search = _searchController.text.trim().toLowerCase();

    return assets.where((asset) {
      final matchesSearch =
          search.isEmpty ||
          asset.assetName.toLowerCase().contains(search) ||
          (asset.serial ?? '').toLowerCase().contains(search) ||
          (asset.assetClass ?? '').toLowerCase().contains(search) ||
          (asset.assetCategory ?? '').toLowerCase().contains(search);

      final matchesStatus =
          _selectedStatus == null ||
          _selectedStatus!.isEmpty ||
          asset.status == _selectedStatus;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final assetState = ref.watch(farAssetListControllerProvider);

    return BsPage(
      title: 'Fixed Assets',
      breadcrumb: BsBreadcrumb(
        items: const [
          BsBreadcrumbItem(label: 'Home'),
          BsBreadcrumbItem(label: 'FAR'),
          BsBreadcrumbItem(label: 'Fixed Assets'),
        ],
      ),
      header: BsPageHeader(
        title: 'Fixed Assets',
        subtitle: 'Fixed Asset Register',
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
              _buildFilters(),
              const SizedBox(height: 12),
              Expanded(child: _buildGrid(filtered)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: TextField(
            controller: _searchController,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: 'Search asset name, serial, category...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {});
                      },
                    )
                  : null,
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 180,
          child: DropdownButtonFormField<String?>(
            value: _selectedStatus,
            decoration: const InputDecoration(labelText: 'Status'),
            items: const [
              DropdownMenuItem(value: null, child: Text('All')),
              DropdownMenuItem(value: 'Draft', child: Text('Draft')),
              DropdownMenuItem(value: 'Posted', child: Text('Posted')),
              DropdownMenuItem(value: 'Active', child: Text('Active')),
              DropdownMenuItem(value: 'Disposed', child: Text('Disposed')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedStatus = value;
              });
            },
          ),
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
        title: 'Asset Name',
        field: 'assetName',
        type: PlutoColumnType.text(),
        width: 220,
      ),
      PlutoColumn(
        title: 'Asset Class',
        field: 'assetClass',
        type: PlutoColumnType.text(),
        width: 160,
      ),
      PlutoColumn(
        title: 'Category',
        field: 'assetCategory',
        type: PlutoColumnType.text(),
        width: 160,
      ),
      PlutoColumn(
        title: 'Brand',
        field: 'brand',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Model',
        field: 'model',
        type: PlutoColumnType.text(),
        width: 130,
      ),
      PlutoColumn(
        title: 'Serial',
        field: 'serial',
        type: PlutoColumnType.text(),
        width: 150,
      ),
      PlutoColumn(
        title: 'Acquisition Date',
        field: 'acquisitionDate',
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
        title: 'Currency',
        field: 'currency',
        type: PlutoColumnType.text(),
        width: 100,
      ),
      PlutoColumn(
        title: 'Status',
        field: 'status',
        type: PlutoColumnType.text(),
        width: 120,
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        width: 130,
        enableSorting: false,
        enableFilterMenuItem: false,
      ),
    ];

    final rows = assets.map((asset) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: asset.id),
          'assetName': PlutoCell(value: asset.assetName),
          'assetClass': PlutoCell(value: asset.assetClass ?? ''),
          'assetCategory': PlutoCell(value: asset.assetCategory ?? ''),
          'brand': PlutoCell(value: asset.brand ?? ''),
          'model': PlutoCell(value: asset.model ?? ''),
          'serial': PlutoCell(value: asset.serial ?? ''),
          'acquisitionDate': PlutoCell(
            value: _formatDate(asset.acquisitionDate),
          ),
          'purchaseCost': PlutoCell(value: asset.purchaseCost ?? 0),
          'currency': PlutoCell(value: asset.currency ?? ''),
          'status': PlutoCell(value: asset.status ?? 'Draft'),
          'action': PlutoCell(value: ''),
        },
      );
    }).toList();

    return BsPlutoGrid(columns: columns, rows: rows);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}
