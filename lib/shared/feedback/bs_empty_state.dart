/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_empty_state.dart
 Purpose      : standard empty data state.
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

class BsEmptyState extends StatelessWidget {
  const BsEmptyState({
    super.key,
    this.message = 'No data found.',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.inbox_outlined, size: 40, color: Theme.of(context).colorScheme.outline),
          const SizedBox(height: 8),
          Text(message),
        ],
      ),
    );
  }
}
