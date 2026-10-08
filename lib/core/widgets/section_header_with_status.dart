/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : section_header_with_status.dart
 Purpose      : Compact section header with optional context action and status chip.
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

class SectionHeaderWithStatus extends StatelessWidget {
  const SectionHeaderWithStatus({
    super.key,
    required this.title,
    this.status,
    this.onContextPressed,
    this.showContextIcon = false,
  });

  final String title;
  final String? status;
  final VoidCallback? onContextPressed;
  final bool showContextIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(title, style: theme.textTheme.titleSmall),
        if (showContextIcon) ...[
          const SizedBox(width: 4),
          IconButton(
            tooltip: 'Screen context',
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints.tightFor(width: 30, height: 30),
            icon: const Icon(Icons.info_outline, size: 17),
            onPressed: onContextPressed,
          ),
        ],
        const Spacer(),
        if (status != null && status!.trim().isNotEmpty)
          DecoratedBox(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              border: Border.all(color: theme.colorScheme.outlineVariant),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Status: ${status!}',
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
