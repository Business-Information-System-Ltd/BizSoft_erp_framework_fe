/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : branch_list_page.dart
 Purpose      : Branch list page.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

===============================================================================
*/

import 'package:bizsoft_frontend_framework/shared/status/bs_status_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import '../../../../../shared/buttons/bs_download_button.dart';
import '../../../../../shared/buttons/bs_new_button.dart';
import '../../../../../shared/buttons/bs_refresh_button.dart';
import '../../../../../shared/feedback/bs_error_state.dart';
import '../../../../../shared/feedback/bs_loading_overlay.dart';
import '../../../../../shared/grid/bs_pluto_grid.dart';
import '../../../../../shared/inputs/bs_dropdown_field.dart';
import '../../../../../shared/layout/bs_page.dart';
import '../../../../../shared/layout/bs_page_header.dart';
import '../../../../../shared/navigation/bs_breadcrumb.dart';
import '../../../../../shared/navigation/bs_breadcrumb_item.dart';
import '../../../../../shared/status/bs_status_badge.dart';
import 'dart:html' as html;
import '../controller/branch_list_controller.dart';
import '../../../../../core/legal_entity/bs_current_legal_entity_provider.dart';

class BranchListPage extends ConsumerStatefulWidget {
  const BranchListPage({super.key});

  @override
  ConsumerState<BranchListPage> createState() => _BranchListPageState();
}

class _BranchListPageState extends ConsumerState<BranchListPage> {
  final TextEditingController _searchController = TextEditingController();

  String? _selectedBranchType;

  String? _selectedStatus;
  bool _isDownloading = false;
  int? _lastLegalEntityId;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) {
        return;
      }

      ref.read(branchListControllerProvider.notifier).refresh();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> _getBranchTypeOptions(List<dynamic> branches) {
    final values = branches
        .map<String?>((branch) {
          final value = branch.branchType;

          if (value == null) {
            return null;
          }

          final text = value.toString().trim();

          if (text.isEmpty) {
            return null;
          }

          return text;
        })
        .whereType<String>()
        .toSet()
        .toList();

    values.sort();

    return values;
  }

  Future<void> _refreshBranches() async {
    setState(() {
      _selectedBranchType = null;
      _selectedStatus = null;
      _searchController.clear();
    });

    await ref.read(branchListControllerProvider.notifier).clearFilters();
  }

  Future<void> _applyFilters() async {
    await ref
        .read(branchListControllerProvider.notifier)
        .applyFilters(
          branchType: _selectedBranchType,
          status: _statusToApiValue(_selectedStatus),
        );
  }

  Future<void> _onStatusChanged(String? value) async {
    setState(() {
      _selectedStatus = value;
    });

    await _applyFilters();
  }

  String? _statusToApiValue(String? status) {
    if (status == 'Active') {
      return 'ACTIVE';
    }

    if (status == 'Inactive') {
      return 'INACTIVE';
    }

    return null;
  }

  Future<void> _search() async {
    await ref
        .read(branchListControllerProvider.notifier)
        .searchBranches(_searchController.text.trim());
  }

  Future<void> _clearSearch() async {
    _searchController.clear();

    setState(() {});

    await _search();
  }

  Future<void> _savePdfFile(List<int> bytes, {required String fileName}) async {
    final blob = html.Blob([bytes], 'application/pdf');

    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  Future<void> _downloadBranches() async {
    if (_isDownloading) {
      return;
    }

    setState(() {
      _isDownloading = true;
    });

    try {
      final currentLegalEntity = ref.read(bsCurrentLegalEntityProvider);

      if (currentLegalEntity == null) {
        if (!mounted) {
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a Legal Entity first.')),
        );

        return;
      }
      final exportService = ref.read(branchExportServiceProvider);

      final status = _statusToApiValue(_selectedStatus);

      final search = _searchController.text.trim();

      debugPrint('BRANCH PDF DOWNLOAD');
      debugPrint('legal_entity: ${currentLegalEntity.id}');

      debugPrint(
        'legal_entity_name: '
        '${currentLegalEntity.legalEntityName}',
      );

      debugPrint('branch_type: $_selectedBranchType');

      debugPrint('is_active: $status');

      debugPrint('search: $search');

      final bytes = await exportService.downloadPdf(
        legalEntityId: currentLegalEntity.id,
        branchType: _selectedBranchType,
        status: status,
        search: search,
      );

      await _savePdfFile(bytes, fileName: 'branch_list.pdf');

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Branch PDF downloaded successfully.')),
      );
    } catch (error) {
      debugPrint('BRANCH PDF DOWNLOAD ERROR: $error');

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download branch PDF: $error')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final legalEntity = ref.watch(bsCurrentLegalEntityProvider);
    final branches = ref.watch(branchListControllerProvider);
    _lastLegalEntityId = legalEntity?.id;

    return BsPage(
      title: 'Branches',

      breadcrumb: const BsBreadcrumb(
        items: [
          BsBreadcrumbItem(label: 'Home', routePath: '/'),
          BsBreadcrumbItem(label: 'Common Setup'),
          BsBreadcrumbItem(label: 'Branch'),
        ],
      ),

      header: BsPageHeader(
        title: 'Branch Master List',

        actions: [
          BsStatusBadge(
            text: '${branches.value?.length ?? 0} Records',
            type: BsStatusType.info,
          ),

          BsNewButton(
            onPressed: () {
              context.go('/common/branches/new');
            },
          ),

          BsRefreshButton(onPressed: _refreshBranches),
        ],
      ),

      body: branches.when(
        loading: () {
          return const BsLoadingOverlay(
            isLoading: true,
            child: SizedBox.expand(),
          );
        },

        error: (error, stackTrace) {
          return BsErrorState(
            message: error.toString(),

            onRetry: () {
              ref.read(branchListControllerProvider.notifier).refresh();
            },
          );
        },

        data: (branchList) {
          final branchTypeOptions = _getBranchTypeOptions(branchList);

          if (_selectedBranchType != null &&
              !branchTypeOptions.contains(_selectedBranchType)) {
            _selectedBranchType = null;
          }

          const statusOptions = <String>['Active', 'Inactive'];

          final columns = <PlutoColumn>[
            PlutoColumn(
              title: 'ID',
              field: 'id',
              type: PlutoColumnType.number(),
              hide: true,
            ),

            PlutoColumn(
              title: 'Branch Code',
              field: 'branchCode',
              type: PlutoColumnType.text(),
              width: 130,
            ),

            PlutoColumn(
              title: 'Branch Name',
              field: 'branchName',
              type: PlutoColumnType.text(),
              width: 170,
            ),

            PlutoColumn(
              title: 'Branch Type',
              field: 'branchType',
              type: PlutoColumnType.text(),
              width: 150,
            ),

            PlutoColumn(
              title: 'Region',
              field: 'region',
              type: PlutoColumnType.text(),
              width: 140,
            ),

            PlutoColumn(
              title: 'Zone',
              field: 'zone',
              type: PlutoColumnType.text(),
              width: 160,
            ),

            PlutoColumn(
              title: 'Head Office',
              field: 'isHeadOffice',
              type: PlutoColumnType.text(),
              width: 125,
            ),

            PlutoColumn(
              title: 'Bank Branch',
              field: 'isBankBranch',
              type: PlutoColumnType.text(),
              width: 125,
            ),

            PlutoColumn(
              title: 'Status',
              field: 'isActive',
              type: PlutoColumnType.text(),
              width: 90,
              enableEditingMode: false,

              renderer: (rendererContext) {
                final rawValue = rendererContext.cell.value;

                final bool isActive = rawValue == true;

                final id = rendererContext.row.cells['id']?.value;

                final branchId = id is int
                    ? id
                    : int.tryParse(id?.toString() ?? '');

                return Transform.scale(
                  scale: 0.70,
                  child: BsStatusSwitch(
                    value: isActive,
                    onChanged: branchId == null
                        ? null
                        : (bool newValue) async {
                            debugPrint('Branch $branchId status: $newValue');
                          },
                  ),
                );
              },
            ),

            PlutoColumn(
              title: 'Action',
              field: 'action',
              type: PlutoColumnType.text(),
              width: 160,
              enableEditingMode: false,

              renderer: (rendererContext) {
                final id = rendererContext.row.cells['id']?.value;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    TextButton(
                      onPressed: () {
                        final branchId = id is int
                            ? id
                            : int.tryParse(id?.toString() ?? '');

                        if (branchId == null) {
                          return;
                        }

                        context.go('/common/branches/$branchId/edit');
                      },
                      child: const Text('Edit'),
                    ),
                    TextButton(
                      onPressed: () {
                        context.go('/common/branches/$id');
                        // Action will be added later.
                      },
                      child: const Text('View'),
                    ),
                  ],
                );
              },
            ),
          ];

          final rows = branchList.map((branch) {
            return PlutoRow(
              cells: {
                'id': PlutoCell(value: branch.id),

                'branchCode': PlutoCell(value: branch.branchCode),

                'branchName': PlutoCell(value: branch.branchName),

                'branchType': PlutoCell(value: branch.branchType),

                'region': PlutoCell(
                  value: branch.regionDetail?.regionName ?? '',
                ),

                'zone': PlutoCell(value: branch.zoneDetail?.zoneName ?? ''),
                'isHeadOffice': PlutoCell(
                  value: branch.isHeadOffice == true ? 'Yes' : 'No',
                ),

                'isBankBranch': PlutoCell(
                  value: branch.isBankBranch == true ? 'Yes' : 'No',
                ),

                'isActive': PlutoCell(value: branch.isActive == true),

                'action': PlutoCell(value: ''),
              },
            );
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  // SizedBox(
                  //   width: 210,

                  //   child: BsDropdownField<String>(
                  //     label: 'Branch Type',

                  //     value: _selectedBranchType,

                  //     items: branchTypeOptions.map((branchType) {
                  //       return DropdownMenuItem<String>(
                  //         value: branchType,

                  //         child: Text(branchType),
                  //       );
                  //     }).toList(),

                  //     onChanged: _onBranchTypeChanged,
                  //   ),
                  // ),

                  // const SizedBox(width: 12),
                  SizedBox(
                    width: 180,

                    child: BsDropdownField<String>(
                      label: 'Status',

                      value: _selectedStatus,

                      items: statusOptions.map((status) {
                        return DropdownMenuItem<String>(
                          value: status,

                          child: Text(status),
                        );
                      }).toList(),

                      onChanged: _onStatusChanged,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: SizedBox(
                      height: 35,
                      child: TextField(
                        controller: _searchController,

                        decoration: InputDecoration(
                          labelText: 'Search',

                          hintText: 'Search branch...',

                          border: const OutlineInputBorder(),

                          prefixIcon: const Icon(Icons.search),

                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  tooltip: 'Clear search',

                                  icon: const Icon(Icons.close, size: 20),

                                  onPressed: _clearSearch,
                                )
                              : null,
                        ),

                        onChanged: (value) {
                          setState(() {});
                        },

                        onSubmitted: (value) {
                          _search();
                        },
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  BsDownloadButton(
                    onPressed: _downloadBranches,
                    isLoading: _isDownloading,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: BsPlutoGrid(
                  columns: columns,

                  rows: rows,

                  mode: PlutoGridMode.selectWithOneTap,

                  onSelected: (event) {
                    final id = event.row?.cells['id']?.value;

                    if (id != null) {
                      context.go('/common/branches/$id');
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
