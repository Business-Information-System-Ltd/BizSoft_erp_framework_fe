/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app_constants.dart
 Purpose      : shared application constants.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsAppConstants {
  const BsAppConstants._();

  // static const defaultApiBaseUrl ='http://118.27.147.94:8000/';
  static const String defaultApiBaseUrl = 'http://118.27.147.94:8001';
  // static const defaultApiBaseUrl ='http://127.0.0.1:8000/';
  static const defaultPagePadding = 16.0;
  static const defaultCardRadius = 8.0;
}
