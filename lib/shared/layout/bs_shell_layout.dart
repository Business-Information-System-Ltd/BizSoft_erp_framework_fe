/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_shell_layout.dart
 Purpose      : Backward-compatible shell layout wrapper.
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

import 'bs_app_shell.dart';

class BsShellLayout extends StatelessWidget {
  const BsShellLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BsAppShell(child: child);
  }
}
