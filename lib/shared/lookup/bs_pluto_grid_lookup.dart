/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_pluto_grid_lookup.dart
 Purpose      : PlutoGrid popup/table for lookup results.
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

import 'bs_lookup_column.dart';
import 'bs_lookup_models.dart';

class BsPlutoGridLookup extends StatelessWidget {
  const BsPlutoGridLookup({
    super.key,
    required this.columns,
    required this.rows,
    required this.onSelected,
  });

  final List<BsLookupColumn> columns;
  final List<Map<String, dynamic>> rows;
  final ValueChanged<BsLookupSelectionResult> onSelected;

  @override
  Widget build(BuildContext context) {
    final plutoColumns = [
      for (final column in columns)
        PlutoColumn(
          title: column.title,
          field: column.field,
          type: PlutoColumnType.text(),
          width: column.width,
        ),
    ];
    final plutoRows = [
      for (final row in rows)
        PlutoRow(
          cells: {
            for (final column in columns) column.field: PlutoCell(value: row[column.field] ?? ''),
          },
        ),
    ];

    return SizedBox(
      height: 320,
      child: PlutoGrid(
        columns: plutoColumns,
        rows: plutoRows,
        mode: PlutoGridMode.selectWithOneTap,
        onSelected: (event) {
          final row = event.row;
          if (row == null) {
            return;
          }
          final raw = <String, dynamic>{
            for (final entry in row.cells.entries) entry.key: entry.value.value,
          };
          onSelected(
            BsLookupSelectionResult(
              id: raw['id'] ?? raw['code'] ?? (raw.values.isEmpty ? '' : raw.values.first),
              code: '${raw['code'] ?? ''}',
              displayText: '${raw['name'] ?? raw['displayText'] ?? raw['code'] ?? ''}',
              rawData: raw,
            ),
          );
        },
      ),
    );
  }
}
