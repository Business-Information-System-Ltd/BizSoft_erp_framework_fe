/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app_notification.dart
 Purpose      : Application notification model used by header and footer shell widgets.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
enum BsNotificationType { info, success, warning, error }

class BsAppNotification {
  const BsAppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String message;
  final BsNotificationType type;
  final bool isRead;
  final DateTime createdAt;
}
