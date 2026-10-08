/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : compact_erp_tab_bar.dart
 Purpose      : Compact text-only tab bar for ERP data entry forms.
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

class CompactErpTabBar extends StatelessWidget {
  const CompactErpTabBar({
    super.key,
    required this.labels,
    this.height = 38,
    this.isScrollable = true,
  });

  final List<String> labels;
  final double height;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: height,
      child: TabBar(
        isScrollable: isScrollable,
        tabAlignment: isScrollable ? TabAlignment.start : null,
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
        indicatorColor: theme.colorScheme.primary,
        indicatorWeight: 2,
        dividerColor: theme.colorScheme.outlineVariant,
        labelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: theme.textTheme.labelLarge,
        labelPadding: const EdgeInsets.symmetric(horizontal: 12),
        padding: EdgeInsets.zero,
        tabs: [
          for (final label in labels) Tab(height: height - 2, text: label),
        ],
      ),
    );
  }
}
