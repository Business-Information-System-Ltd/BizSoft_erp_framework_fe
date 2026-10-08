/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_approval_badge.dart
 Purpose      : standard approval status badge.
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

import 'bs_status_badge.dart';

class BsApprovalBadge extends StatelessWidget {
  const BsApprovalBadge({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return BsStatusBadge(text: text, type: BsStatusType.info);
  }
}
