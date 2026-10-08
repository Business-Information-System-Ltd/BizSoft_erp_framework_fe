/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_notification_provider.dart
 Purpose      : Riverpod providers for notifications and mock system status.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'bs_app_notification.dart';
import 'bs_notification_service.dart';

enum BsSystemStatus { online, offline, connecting, error }

final bsNotificationServiceProvider = Provider<BsNotificationService>((ref) {
  return const BsNotificationService();
});

final bsNotificationsProvider = StateProvider<List<BsAppNotification>>((ref) {
  return ref.watch(bsNotificationServiceProvider).getNotifications();
});

final bsUnreadNotificationCountProvider = Provider<int>((ref) {
  return ref
      .watch(bsNotificationsProvider)
      .where((item) => !item.isRead)
      .length;
});

final bsErrorNotificationCountProvider = Provider<int>((ref) {
  return ref
      .watch(bsNotificationsProvider)
      .where((item) => item.type == BsNotificationType.error)
      .length;
});

final bsSystemStatusProvider = StateProvider<BsSystemStatus>((ref) {
  return BsSystemStatus.online;
});
