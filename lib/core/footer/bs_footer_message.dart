/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_footer_message.dart
 Purpose      : Footer message model for shell-level validation, error, and status messages.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
enum BsFooterMessageType { success, info, warning, error, validation }

class BsFooterMessage {
  BsFooterMessage({
    required this.message,
    required this.type,
    this.duration = const Duration(seconds: 2),
    DateTime? createdAt,
    String? id,
  })  : id = id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        createdAt = createdAt ?? DateTime.now();

  final String id;
  final String message;
  final BsFooterMessageType type;
  final Duration duration;
  final DateTime createdAt;
}