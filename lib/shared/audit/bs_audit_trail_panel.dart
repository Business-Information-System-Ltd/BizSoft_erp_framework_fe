/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_audit_trail_panel.dart
 Purpose      : audit trail display panel.
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

import '../../core/utils/bs_date_utils.dart';
import 'bs_audit_models.dart';

class BsAuditTrailPanel extends StatelessWidget {
  const BsAuditTrailPanel({
    super.key,
    required this.items,
  });

  final List<BsAuditTrailItem> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text('No audit trail.');
    }
    return Column(
      children: [
        for (final item in items)
          ListTile(
            dense: true,
            leading: const Icon(Icons.history),
            title: Text(item.action),
            subtitle: Text('${item.userName} - ${BsDateUtils.formatDate(item.dateTime)}'),
          ),
      ],
    );
  }
}
