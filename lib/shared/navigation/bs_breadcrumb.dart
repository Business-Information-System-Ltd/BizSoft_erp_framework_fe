/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_breadcrumb.dart
 Purpose      : Compact ERP breadcrumb widget for routed BizSoft pages.
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

import 'bs_breadcrumb_item.dart';

class BsBreadcrumb extends StatelessWidget {
  const BsBreadcrumb({super.key, required this.items});

  final List<BsBreadcrumbItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      runSpacing: 4,
      children: [
        for (var index = 0; index < items.length; index++) ...[
          _BreadcrumbSegment(
            item: items[index],
            isLast: index == items.length - 1,
          ),
          if (index != items.length - 1)
            Icon(
              Icons.chevron_right,
              size: 15,
              color: theme.colorScheme.onSurfaceVariant,
            ),
        ],
      ],
    );
  }
}

class _BreadcrumbSegment extends StatelessWidget {
  const _BreadcrumbSegment({required this.item, required this.isLast});

  final BsBreadcrumbItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final routePath = item.routePath;
    final style = theme.textTheme.bodySmall?.copyWith(
      color: isLast ? theme.colorScheme.onSurface : theme.colorScheme.primary,
      fontWeight: isLast ? FontWeight.w600 : FontWeight.w500,
    );

    if (isLast || routePath == null || routePath.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(item.label, style: style),
      );
    }

    return InkWell(
      borderRadius: BorderRadius.circular(3),
      onTap: () => context.go(routePath),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        child: Text(item.label, style: style),
      ),
    );
  }
}
