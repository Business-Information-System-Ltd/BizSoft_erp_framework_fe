/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_footer_bar.dart
 Purpose      : Bottom compact ERP footer bar with message, system name, and live clock.
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

import '../../app/bs_app_theme.dart';
import '../footer/bs_company_datetime_display.dart';
import '../footer/bs_footer_message_area.dart';
import '../footer/bs_system_name_display.dart';

class BsFooterBar extends StatelessWidget {
  const BsFooterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: Container(
        height: BsAppTheme.footerHeight,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: theme.dividerColor)),
        ),
        child: DefaultTextStyle.merge(
          style: theme.textTheme.bodySmall,
          child: const Row(
            children: [
              Expanded(flex: 3, child: BsFooterMessageArea()),
              Expanded(flex: 2, child: Center(child: BsSystemNameDisplay())),
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: BsCompanyDateTimeDisplay(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
