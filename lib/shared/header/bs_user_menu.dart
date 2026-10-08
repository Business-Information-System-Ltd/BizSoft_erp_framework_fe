/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_user_menu.dart
 Purpose      : Header current user menu widget.
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

import '../../core/auth/bs_permission_provider.dart';
import '../../core/footer/bs_footer_message_provider.dart';

class BsUserMenu extends ConsumerWidget {
  const BsUserMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(bsCurrentUserProvider);
    return PopupMenuButton<String>(
      tooltip: 'User menu',
      offset: const Offset(0, 44),
      onSelected: (value) => ref.read(bsFooterMessageProvider.notifier).showInfo('$value selected'),
      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.displayName, style: Theme.of(context).textTheme.titleSmall),
              Text(user.roles.join(', '), style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'Profile', child: Text('Profile')),
        const PopupMenuItem(value: 'Change Password', child: Text('Change Password')),
        const PopupMenuItem(value: 'Preferences', child: Text('Preferences')),
        const PopupMenuDivider(),
        const PopupMenuItem(value: 'Sign out', child: Text('Sign out')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(radius: 13, child: Icon(Icons.person_outline, size: 17)),
            const SizedBox(width: 8),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 150),
              child: Text(user.displayName, overflow: TextOverflow.ellipsis),
            ),
            const Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }
}