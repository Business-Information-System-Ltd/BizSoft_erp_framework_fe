/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_validation_message_panel.dart
 Purpose      : displays frontend or backend validation messages.
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

import '../../core/validators/bs_validation_message.dart';

class BsValidationMessagePanel extends StatelessWidget {
  const BsValidationMessagePanel({super.key, required this.messages});

  final List<BsValidationMessage> messages;

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.35),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.4),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final item in messages)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Text(
                  item.fieldName == null
                      ? item.message
                      : '${item.fieldName}: ${item.message}',
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
