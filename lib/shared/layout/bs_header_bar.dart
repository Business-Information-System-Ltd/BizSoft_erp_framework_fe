/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_header_bar.dart
 Purpose      : Top ERP-style application header bar.
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
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/bs_app_theme.dart';
import '../../core/shell/bs_shell_state_provider.dart';

import '../header/bs_legal_entity_selector.dart';
import '../header/bs_help_button.dart';
import '../header/bs_notification_button.dart';
import '../header/bs_user_menu.dart';

import '../theme/bs_theme_switcher.dart';

class BsHeaderBar
    extends ConsumerWidget {
  const BsHeaderBar({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final theme =
        Theme.of(context);

    return Material(
      color:
          theme.colorScheme.surface,

      child: Container(
        height:
            BsAppTheme.headerHeight,

        padding:
            const EdgeInsets.symmetric(
          horizontal: 10,
        ),

        decoration:
            BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  theme.dividerColor,
            ),
          ),
        ),

        child: Row(
          children: [
            IconButton(
              tooltip:
                  'Expand or collapse menu',

              icon:
                  const Icon(
                Icons.menu,
                size: 22,
              ),

              onPressed: () {
                ref
                    .read(
                      bsShellStateProvider
                          .notifier,
                    )
                    .toggleSideMenu();
              },
            ),

            const SizedBox(
              width: 6,
            ),

            const Expanded(
              child: Align(
                alignment:
                    Alignment.centerLeft,

                child:
                    BsLegalEntitySelector(),
              ),
            ),

            const SizedBox(
              width: 8,
            ),

            const BsNotificationButton(),

            const SizedBox(
              width: 4,
            ),

            const BsHelpButton(),

            const SizedBox(
              width: 4,
            ),

            const BsThemeSwitcher(),

            const SizedBox(
              width: 8,
            ),

            const BsUserMenu(),
          ],
        ),
      ),
    );
  }
}