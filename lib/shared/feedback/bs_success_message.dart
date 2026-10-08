/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_success_message.dart
 Purpose      : standard success message panel.
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

class BsSuccessMessage extends StatelessWidget {
  const BsSuccessMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.withValues(alpha: 0.10),
      child: ListTile(
        leading: const Icon(Icons.check_circle, color: Colors.green),
        title: Text(message),
      ),
    );
  }
}
