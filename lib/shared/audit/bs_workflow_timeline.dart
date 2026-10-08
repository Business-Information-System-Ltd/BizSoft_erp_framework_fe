/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_workflow_timeline.dart
 Purpose      : simple workflow timeline display.
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

import 'bs_audit_models.dart';

class BsWorkflowTimeline extends StatelessWidget {
  const BsWorkflowTimeline({super.key, required this.items});

  final List<BsAuditTrailItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items)
          ListTile(
            leading: const Icon(Icons.radio_button_checked),
            title: Text(item.action),
            subtitle: Text(item.remarks ?? item.userName),
          ),
      ],
    );
  }
}
