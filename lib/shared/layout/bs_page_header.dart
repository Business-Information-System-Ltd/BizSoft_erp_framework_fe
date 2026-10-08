/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_page_header.dart
 Purpose      : Standard page title area with upper-right page action support.
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

import 'bs_page_action_bar.dart';

class BsPageHeader extends StatelessWidget {
  const BsPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.status,
    this.actions,
  });

  final String title;
  final String? subtitle;
  final Widget? status;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              if (subtitle != null)
                Text(subtitle!, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        if (status != null) ...[status!, const SizedBox(width: 12)],
        if (actions != null && actions!.isNotEmpty)
          Flexible(child: BsPageActionBar(actions: actions!)),
      ],
    );
  }
}
