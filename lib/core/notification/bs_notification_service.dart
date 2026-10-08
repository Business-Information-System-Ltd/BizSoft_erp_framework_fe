/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_notification_service.dart
 Purpose      : Mock notification service for application shell notifications.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_app_notification.dart';

class BsNotificationService {
  const BsNotificationService();

  List<BsAppNotification> getNotifications() {
    final now = DateTime.now();
    return <BsAppNotification>[
      BsAppNotification(
        id: 'n1',
        title: 'System Ready',
        message: 'BizSoft framework shell is online.',
        type: BsNotificationType.success,
        isRead: false,
        createdAt: now,
      ),
      BsAppNotification(
        id: 'n2',
        title: 'Approval Pending',
        message: 'Two documents are waiting for review.',
        type: BsNotificationType.info,
        isRead: false,
        createdAt: now.subtract(const Duration(minutes: 8)),
      ),
      BsAppNotification(
        id: 'n3',
        title: 'Backup Reminder',
        message: 'Daily backup should be verified.',
        type: BsNotificationType.warning,
        isRead: true,
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
    ];
  }
}
