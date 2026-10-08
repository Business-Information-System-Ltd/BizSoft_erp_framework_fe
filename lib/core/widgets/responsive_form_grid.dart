/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : responsive_form_grid.dart
 Purpose      : Compact responsive form grid for ERP data entry screens.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'dart:math' as math;

import 'package:flutter/material.dart';

class ResponsiveFormGrid extends StatelessWidget {
  const ResponsiveFormGrid({
    super.key,
    required this.children,
    this.minFieldWidth = 260,
    this.maxColumns = 3,
    this.spacing = 12,
    this.runSpacing = 8,
  });

  final List<Widget> children;
  final double minFieldWidth;
  final int maxColumns;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : minFieldWidth;
        final columns = math.max(
          1,
          math.min(maxColumns, (availableWidth / minFieldWidth).floor()),
        );
        final fieldWidth =
            (availableWidth - (spacing * (columns - 1))) / columns;

        return Wrap(
          spacing: spacing,
          runSpacing: runSpacing,
          children: [
            for (final child in children)
              if (child is ResponsiveFormGridFullWidth)
                SizedBox(width: availableWidth, child: child.child)
              else if (child is ResponsiveFormGridSpan)
                SizedBox(
                  width: _spannedWidth(
                    fieldWidth: fieldWidth,
                    columns: columns,
                    span: child.columns,
                  ),
                  child: child.child,
                )
              else
                SizedBox(width: fieldWidth, child: child),
          ],
        );
      },
    );
  }

  double _spannedWidth({
    required double fieldWidth,
    required int columns,
    required int span,
  }) {
    final effectiveSpan = span.clamp(1, columns);
    return (fieldWidth * effectiveSpan) + (spacing * (effectiveSpan - 1));
  }
}

class ResponsiveFormGridFullWidth extends StatelessWidget {
  const ResponsiveFormGridFullWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class ResponsiveFormGridSpan extends StatelessWidget {
  const ResponsiveFormGridSpan({
    super.key,
    required this.columns,
    required this.child,
  });

  final int columns;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
