/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : sample_home_page.dart
 Purpose      : sample home page.
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
import 'package:go_router/go_router.dart';

import '../shared/buttons/bs_action_button.dart';
import '../shared/layout/bs_page.dart';
import '../shared/layout/bs_section_card.dart';
import '../shared/layout/bs_toolbar.dart';

class SampleHomePage extends StatelessWidget {
  const SampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BsPage(
      title: 'BizSoft Frontend Framework',
      toolbar: BsToolbar(
        children: [
          BsActionButton(
            label: 'Master List',
            icon: Icons.table_rows,
            onPressed: () => context.go('/sample/master-list'),
          ),
          BsActionButton(
            label: 'Master Form',
            icon: Icons.edit_note,
            onPressed: () => context.go('/sample/master-form'),
          ),
          BsActionButton(
            label: 'Lookup',
            icon: Icons.search,
            onPressed: () => context.go('/sample/lookup'),
          ),
          BsActionButton(
            label: 'Report',
            icon: Icons.assessment,
            onPressed: () => context.go('/sample/report'),
          ),
          BsActionButton(
            label: 'Material Widgets',
            icon: Icons.widgets,
            onPressed: () => context.go('/sample/material-widgets'),
          ),
          BsActionButton(
            label: 'Branches',
            icon: Icons.account_tree,
            onPressed: () => context.go('/common/branches'),
          ),
        ],
      ),
      body: const BsSectionCard(
        title: 'Welcome',
        child: Text(
          'Use the menu and sample pages to learn how to build BizSoft screens with reusable Bs widgets.',
        ),
      ),
    );
  }
}
