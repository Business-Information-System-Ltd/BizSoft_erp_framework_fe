/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : settings_profile_page.dart
 Purpose      : Settings profile placeholder page.
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

class SettingsProfilePage extends StatelessWidget {
  const SettingsProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BsPage(
      title: 'User Profile',
      body: BsSectionCard(
        title: 'Profile',
        child: Text('User profile settings will be implemented here.'),
      ),
    );
  }
}
