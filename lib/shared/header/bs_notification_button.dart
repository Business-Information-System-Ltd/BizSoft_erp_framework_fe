/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_notification_button.dart
 Purpose      : Header notification button with unread count popup.
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

import '../../core/notification/bs_app_notification.dart';
import '../../core/notification/bs_notification_provider.dart';

class BsNotificationButton extends ConsumerWidget {
  const BsNotificationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(bsNotificationsProvider);
    final unreadCount = ref.watch(bsUnreadNotificationCountProvider);

    return PopupMenuButton<String>(
      tooltip: 'Notifications',
      offset: const Offset(0, 42),
      itemBuilder: (context) => [
        if (notifications.isEmpty)
          const PopupMenuItem(value: 'empty', child: Text('No notifications'))
        else
          for (final item in notifications.take(6))
            PopupMenuItem(
              value: item.id,
              child: SizedBox(
                width: 320,
                child: ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(_iconFor(item.type), color: _colorFor(context, item.type)),
                  title: Text(item.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                  subtitle: Text(item.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                ),
              ),
            ),
      ],
      child: SizedBox(
        width: 40,
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            const Icon(Icons.notifications_none_outlined, size: 22),
            if (unreadCount > 0)
              Positioned(
                right: 4,
                top: 2,
                child: Badge(label: Text('$unreadCount')),
              ),
          ],
        ),
      ),
    );
  }

  static IconData _iconFor(BsNotificationType type) {
    return switch (type) {
      BsNotificationType.info => Icons.info_outline,
      BsNotificationType.success => Icons.check_circle_outline,
      BsNotificationType.warning => Icons.warning_amber_outlined,
      BsNotificationType.error => Icons.error_outline,
    };
  }

  static Color _colorFor(BuildContext context, BsNotificationType type) {
    return switch (type) {
      BsNotificationType.info => Theme.of(context).colorScheme.primary,
      BsNotificationType.success => Colors.green,
      BsNotificationType.warning => Colors.orange,
      BsNotificationType.error => Theme.of(context).colorScheme.error,
    };
  }
}