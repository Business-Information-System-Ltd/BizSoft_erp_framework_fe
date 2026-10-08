/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : settings_system_page.dart
 Purpose      : System settings placeholder page.
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

import '../../shared/layout/bs_page.dart';
import '../../shared/layout/bs_section_card.dart';

class SettingsSystemPage extends StatelessWidget {
  const SettingsSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BsPage(
      title: 'System Settings',
      body: BsSectionCard(
        title: 'Settings',
        child: Text('System settings will be implemented here.'),
      ),
    );
  }
}
