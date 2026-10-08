/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app_shell.dart
 Purpose      : Main ERP-style application shell for routed BizSoft pages.
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

import 'bs_footer_bar.dart';
import 'bs_header_bar.dart';
import 'bs_main_content_area.dart';
import 'bs_side_menu.dart';

class BsAppShell extends StatelessWidget {
  const BsAppShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const BsHeaderBar(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const BsSideMenu(),
                VerticalDivider(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
                Expanded(child: BsMainContentArea(child: child)),
              ],
            ),
          ),
          const BsFooterBar(),
        ],
      ),
    );
  }
}
