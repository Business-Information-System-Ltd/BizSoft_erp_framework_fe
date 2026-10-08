/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_validation_message.dart
 Purpose      : validation message model for forms and backend responses.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
enum BsValidationMessageType { info, success, warning, error }

class BsValidationMessage {
  const BsValidationMessage({
    required this.message,
    this.type = BsValidationMessageType.error,
    this.fieldName,
  });

  final String message;
  final BsValidationMessageType type;
  final String? fieldName;
}
