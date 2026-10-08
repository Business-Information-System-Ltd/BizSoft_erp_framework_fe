/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_readonly_grid.dart
 Purpose      : read-only PlutoGrid wrapper.
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

import 'bs_pluto_grid.dart';

class BsReadonlyGrid extends StatelessWidget {
  const BsReadonlyGrid({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;

  @override
  Widget build(BuildContext context) {
    return BsPlutoGrid(columns: columns, rows: rows);
  }
}
