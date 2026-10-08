/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : sample_report_page.dart
 Purpose      : sample report page.
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
import 'package:pluto_grid/pluto_grid.dart';

import '../shared/buttons/bs_search_button.dart';
import '../shared/filters/bs_filter_panel.dart';
import '../shared/filters/bs_report_date_filter.dart';
import '../shared/filters/bs_report_date_models.dart';
import '../shared/grid/bs_pluto_grid.dart';
import '../shared/layout/bs_page.dart';
import '../shared/layout/bs_toolbar.dart';

class SampleReportPage extends StatefulWidget {
  const SampleReportPage({super.key});

  @override
  State<SampleReportPage> createState() => _SampleReportPageState();
}

class _SampleReportPageState extends State<SampleReportPage> {
  BsDateRangeFilterResult? _dateRange;

  @override
  Widget build(BuildContext context) {
    return BsPage(
      title: 'Sample Report',
      toolbar: BsToolbar(children: [BsSearchButton(onPressed: () {})]),
      filterPanel: BsFilterPanel(child: BsReportDateFilter(onChanged: (value) => setState(() => _dateRange = value))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(_dateRange == null ? 'No date range selected.' : 'Selected preset: ${_dateRange!.preset.label}'),
          const SizedBox(height: 12),
          Expanded(
            child: BsPlutoGrid(
              columns: [
                PlutoColumn(title: 'Code', field: 'code', type: PlutoColumnType.text()),
                PlutoColumn(title: 'Description', field: 'description', type: PlutoColumnType.text()),
                PlutoColumn(title: 'Amount', field: 'amount', type: PlutoColumnType.number()),
              ],
              rows: [
                PlutoRow(cells: {
                  'code': PlutoCell(value: 'R001'),
                  'description': PlutoCell(value: 'Opening Balance'),
                  'amount': PlutoCell(value: 1500),
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
