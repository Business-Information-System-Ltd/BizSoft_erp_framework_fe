/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_common_validators.dart
 Purpose      : common reusable frontend validators.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsCommonValidators {
  const BsCommonValidators._();

  static String? requiredField(String? value, {String message = 'This field is required.'}) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? maxLength(String? value, int maxLength) {
    if (value != null && value.length > maxLength) {
      return 'Maximum $maxLength characters allowed.';
    }
    return null;
  }
}
