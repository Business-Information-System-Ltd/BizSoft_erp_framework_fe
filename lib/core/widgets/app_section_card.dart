/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : app_section_card.dart
 Purpose      : *   Provides a reusable section container for Partner UI forms.
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

class AppSectionCard extends StatelessWidget {
  const AppSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.compact = false,
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final padding = compact ? 12.0 : 16.0;
    final titleSpacing = compact ? 8.0 : 12.0;

    return Card(
      margin: EdgeInsets.symmetric(vertical: compact ? 6 : 8),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            SizedBox(height: titleSpacing),
            child,
          ],
        ),
      ),
    );
  }
}
