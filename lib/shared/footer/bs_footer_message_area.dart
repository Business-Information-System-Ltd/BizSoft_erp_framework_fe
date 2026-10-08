/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_footer_message_area.dart
 Purpose      : Temporary lower-left footer message area for validation and status messages.
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/footer/bs_footer_message.dart';
import '../../core/footer/bs_footer_message_provider.dart';

class BsFooterMessageArea extends ConsumerWidget {
  const BsFooterMessageArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final message = ref.watch(bsFooterMessageProvider);
    final theme = Theme.of(context);

    return ClipRect(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 180),
        transitionBuilder: (child, animation) {
          final offset = Tween<Offset>(
            begin: const Offset(0, 0.9),
            end: Offset.zero,
          ).animate(animation);
          return SlideTransition(
            position: offset,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: message == null
            ? const SizedBox(key: ValueKey('empty'), height: 28)
            : Align(
                key: ValueKey(message.id),
                alignment: Alignment.centerLeft,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 520),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _backgroundColor(theme, message.type),
                    border: Border.all(
                      color: _borderColor(theme, message.type),
                    ),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _iconFor(message.type),
                        size: 16,
                        color: _foregroundColor(theme, message.type),
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          message.message,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: _foregroundColor(theme, message.type),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  IconData _iconFor(BsFooterMessageType type) {
    return switch (type) {
      BsFooterMessageType.success => Icons.check_circle_outline,
      BsFooterMessageType.info => Icons.info_outline,
      BsFooterMessageType.warning => Icons.warning_amber_outlined,
      BsFooterMessageType.error => Icons.error_outline,
      BsFooterMessageType.validation => Icons.report_problem_outlined,
    };
  }

  Color _foregroundColor(ThemeData theme, BsFooterMessageType type) {
    return switch (type) {
      BsFooterMessageType.success => Colors.green.shade800,
      BsFooterMessageType.info => theme.colorScheme.primary,
      BsFooterMessageType.warning => Colors.orange.shade900,
      BsFooterMessageType.error => theme.colorScheme.error,
      BsFooterMessageType.validation => theme.colorScheme.error,
    };
  }

  Color _backgroundColor(ThemeData theme, BsFooterMessageType type) {
    final foreground = _foregroundColor(theme, type);
    return Color.alphaBlend(
      foreground.withValues(alpha: 0.10),
      theme.colorScheme.surface,
    );
  }

  Color _borderColor(ThemeData theme, BsFooterMessageType type) {
    return _foregroundColor(theme, type).withValues(alpha: 0.32);
  }
}
