/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_status_chip.dart
 Purpose      : *   Displays Partner status with consistent color coding.
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

import '../../domain/enums/partner_enums.dart';

class PartnerStatusChip extends StatelessWidget {
  const PartnerStatusChip({super.key, required this.status});

  final PartnerStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      PartnerStatus.active => Colors.green,
      PartnerStatus.blocked => Colors.red,
      PartnerStatus.inactive => Colors.grey,
      PartnerStatus.draft => Colors.orange,
    };

    return Chip(
      label: Text(status.label),
      visualDensity: VisualDensity.compact,
      backgroundColor: color.withValues(alpha: 0.12),
      labelStyle: TextStyle(color: color.shade700, fontWeight: FontWeight.w600),
      side: BorderSide(color: color.withValues(alpha: 0.35)),
    );
  }
}
