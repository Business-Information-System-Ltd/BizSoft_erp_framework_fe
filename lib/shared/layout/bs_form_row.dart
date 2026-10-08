/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_form_row.dart
 Purpose      : responsive row for form fields.
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

import '../../core/widgets/responsive_form_grid.dart';

class BsFormRow extends StatelessWidget {
  const BsFormRow({
    super.key,
    required this.children,
    this.fieldWidth = 260,
    this.maxColumns = 3,
    this.spacing = 12,
    this.runSpacing = 8,
  });

  final List<Widget> children;
  final double fieldWidth;
  final int maxColumns;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return ResponsiveFormGrid(
      minFieldWidth: fieldWidth,
      maxColumns: maxColumns,
      spacing: spacing,
      runSpacing: runSpacing,
      children: children,
    );
  }
}
