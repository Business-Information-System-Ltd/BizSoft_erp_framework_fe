/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : sample_master_list_page.dart
 Purpose      : sample master list page.
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
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';

import '../shared/buttons/bs_new_button.dart';
import '../shared/grid/bs_pluto_grid.dart';
import '../shared/layout/bs_page.dart';
import '../shared/layout/bs_toolbar.dart';
import '../shared/search/bs_search_box.dart';
import '../shared/search/bs_search_models.dart';
import '../shared/status/bs_status_badge.dart';

class SampleMasterListPage extends StatefulWidget {
  const SampleMasterListPage({super.key});

  @override
  State<SampleMasterListPage> createState() => _SampleMasterListPageState();
}

class _SampleMasterListPageState extends State<SampleMasterListPage> {
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    final rows = _rows.where((row) => row.values.join(' ').toLowerCase().contains(_searchText.toLowerCase())).toList();
    return BsPage(
      title: 'Sample Master List',
      toolbar: BsToolbar(children: [BsNewButton(onPressed: () => context.go('/sample/master-form'))]),
      filterPanel: BsSearchBox(
        onSearch: (request) => setState(() => _searchText = request.text),
        popupItemsLoader: (_) async => const [
          BsSearchPopupItem(label: 'Code', insertText: 'Code: A*', description: 'Search by code'),
          BsSearchPopupItem(label: 'Name', insertText: 'Name: Yangon*', description: 'Search by name'),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BsStatusBadge(text: '${rows.length} Records', type: BsStatusType.info),
          const SizedBox(height: 12),
          Expanded(
            child: BsPlutoGrid(
              columns: [
                PlutoColumn(title: 'Code', field: 'code', type: PlutoColumnType.text()),
                PlutoColumn(title: 'Name', field: 'name', type: PlutoColumnType.text()),
                PlutoColumn(title: 'Status', field: 'status', type: PlutoColumnType.text()),
              ],
              rows: [
                for (final row in rows)
                  PlutoRow(cells: {
                    'code': PlutoCell(value: row['code']),
                    'name': PlutoCell(value: row['name']),
                    'status': PlutoCell(value: row['status']),
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _rows = [
    {'code': 'A001', 'name': 'Yangon Office', 'status': 'Active'},
    {'code': 'A002', 'name': 'Mandalay Office', 'status': 'Active'},
    {'code': 'A003', 'name': 'Naypyitaw Office', 'status': 'Inactive'},
  ];
}
