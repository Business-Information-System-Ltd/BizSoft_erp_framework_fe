/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_status_badge.dart
 Purpose      : standard status badge.
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

enum BsStatusType { neutral, success, warning, danger, info }

class BsStatusBadge extends StatelessWidget {
  const BsStatusBadge({
    super.key,
    required this.text,
    this.type = BsStatusType.neutral,
  });

  final String text;
  final BsStatusType type;

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      BsStatusType.success => Colors.green,
      BsStatusType.warning => Colors.orange,
      BsStatusType.danger => Colors.red,
      BsStatusType.info => Colors.blue,
      BsStatusType.neutral => Colors.grey,
    };

    return Chip(
      label: Text(text),
      visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      // visualDensity: VisualDensity.compact,
      backgroundColor: color.withValues(alpha: 0.10),
      side: BorderSide(color: color.withValues(alpha: 0.35)),
      labelStyle: TextStyle(color: color.shade700, fontWeight: FontWeight.w600),
    );
  }
}
