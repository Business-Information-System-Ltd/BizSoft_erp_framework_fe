/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : context_info_line.dart
 Purpose      : Compact read-only context chips for ERP entry screens.
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

class ContextInfoLineItem {
  const ContextInfoLineItem({
    required this.label,
    required this.value,
    required this.priority,
  });

  final String label;
  final String value;
  final int priority;
}

class ContextInfoLine extends StatelessWidget {
  const ContextInfoLine({super.key, required this.items});

  final List<ContextInfoLineItem> items;

  @override
  Widget build(BuildContext context) {
    final sorted = List<ContextInfoLineItem>.from(items)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    return LayoutBuilder(
      builder: (context, constraints) {
        final visibleCount = _visibleCountForWidth(
          constraints.maxWidth,
          sorted.length,
        );
        final visible = sorted.take(visibleCount).toList();
        final hidden = sorted.skip(visibleCount).toList();

        return Wrap(
          spacing: 6,
          runSpacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final item in visible) _ContextChip(item: item),
            if (hidden.isNotEmpty)
              Tooltip(
                message: hidden
                    .map((item) => '${item.label}: ${item.value}')
                    .join('\n'),
                child: const Icon(Icons.info_outline, size: 18),
              ),
          ],
        );
      },
    );
  }

  int _visibleCountForWidth(double width, int count) {
    if (!width.isFinite || width >= 1060) {
      return count;
    }
    if (width >= 860) {
      return count.clamp(0, 5);
    }
    if (width >= 660) {
      return count.clamp(0, 4);
    }
    return count.clamp(0, 3);
  }
}

class _ContextChip extends StatelessWidget {
  const _ContextChip({required this.item});

  final ContextInfoLineItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '${item.label}: ',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              TextSpan(
                text: item.value,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
