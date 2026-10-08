/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_pluto_grid.dart
 Purpose      : simple PlutoGrid wrapper for list pages.
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

class BsPlutoGrid extends StatelessWidget {
  const BsPlutoGrid({
    super.key,
    required this.columns,
    required this.rows,
    this.mode = PlutoGridMode.readOnly,
    this.onSelected,
  });

  final List<PlutoColumn> columns;
  final List<PlutoRow> rows;
  final PlutoGridMode mode;
  final PlutoOnSelectedEventCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
    color: colorScheme.surface,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: PlutoGrid(
        columns: columns,
        rows: rows,
        mode: mode,
        onSelected: onSelected,
        configuration: PlutoGridConfiguration(
          style: PlutoGridStyleConfig(
            gridBackgroundColor: colorScheme.surface,
            rowColor: colorScheme.surface,
            activatedColor: colorScheme.surfaceContainerHighest,
            gridBorderColor: colorScheme.outlineVariant,
            borderColor: colorScheme.outlineVariant,
            columnTextStyle: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),

            
              cellTextStyle: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 14,
              ),
          ),
          
        ),
      ),
    ),
  );
  }
}
