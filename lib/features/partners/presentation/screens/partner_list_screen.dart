/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_list_screen.dart
 Purpose      : *   Displays searchable and filterable Partner browse/list screen.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_data_table.dart';
import '../../../../core/widgets/app_dropdown.dart';
import '../../domain/enums/partner_enums.dart';
import '../providers/partner_list_provider.dart';
import '../widgets/partner_status_chip.dart';

class PartnerListScreen extends ConsumerStatefulWidget {
  const PartnerListScreen({super.key});

  @override
  ConsumerState<PartnerListScreen> createState() => _PartnerListScreenState();
}

class _PartnerListScreenState extends ConsumerState<PartnerListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(partnerListProvider.notifier).load());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(partnerListProvider);
    final notifier = ref.read(partnerListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Partners'),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh),
            onPressed: state.loading ? null : () => notifier.load(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('/partners/new'),
        icon: const Icon(Icons.add),
        label: const Text('New Partner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                SizedBox(
                  width: 360,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search partners',
                      suffixIcon: IconButton(
                        tooltip: 'Search',
                        icon: const Icon(Icons.search),
                        onPressed: () => notifier.search(_searchController.text),
                      ),
                    ),
                    onSubmitted: notifier.search,
                  ),
                ),
                SizedBox(
                  width: 240,
                  child: AppDropdown<PartnerType>(
                    label: 'Partner Type',
                    value: state.partnerType,
                    items: [
                      for (final type in PartnerType.values) AppDropdownItem(value: type, label: type.label),
                    ],
                    onChanged: (value) => notifier.setFilters(partnerType: value, clearPartnerType: value == null),
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: AppDropdown<PartnerStatus>(
                    label: 'Status',
                    value: state.status,
                    items: [
                      for (final status in PartnerStatus.values) AppDropdownItem(value: status, label: status.label),
                    ],
                    onChanged: (value) => notifier.setFilters(status: value, clearStatus: value == null),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _searchController.clear();
                    notifier.setFilters(clearPartnerType: true, clearRoleType: true, clearStatus: true);
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (state.error != null)
              MaterialBanner(
                content: Text(state.error!),
                actions: [TextButton(onPressed: notifier.load, child: const Text('Retry'))],
              ),
            if (state.loading) const LinearProgressIndicator(),
            const SizedBox(height: 8),
            Expanded(
              child: AppDataTable(
                columns: const [
                  DataColumn(label: Text('Code')),
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Type')),
                  DataColumn(label: Text('Country')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: [
                  for (final partner in state.items)
                    DataRow(
                      onSelectChanged: (_) {
                        if (partner.id != null) {
                          context.go('/partners/${partner.id}');
                        }
                      },
                      cells: [
                        DataCell(Text(partner.partnerCode ?? '-')),
                        DataCell(Text(partner.displayName ?? partner.legalName ?? '-')),
                        DataCell(Text(partner.partnerType.label)),
                        DataCell(Text(partner.countryCode ?? '-')),
                        DataCell(PartnerStatusChip(status: partner.status)),
                        DataCell(
                          Wrap(
                            spacing: 4,
                            children: [
                              IconButton(
                                tooltip: 'View',
                                icon: const Icon(Icons.visibility),
                                onPressed: partner.id == null ? null : () => context.go('/partners/${partner.id}'),
                              ),
                              IconButton(
                                tooltip: 'Edit',
                                icon: const Icon(Icons.edit),
                                onPressed: partner.id == null ? null : () => context.go('/partners/${partner.id}/edit'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Total: ${state.count}'),
                const SizedBox(width: 16),
                IconButton(
                  tooltip: 'Previous page',
                  icon: const Icon(Icons.chevron_left),
                  onPressed: state.hasPrevious ? () => notifier.load(page: state.page - 1) : null,
                ),
                Text('Page ${state.page}'),
                IconButton(
                  tooltip: 'Next page',
                  icon: const Icon(Icons.chevron_right),
                  onPressed: state.hasNext ? () => notifier.load(page: state.page + 1) : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
