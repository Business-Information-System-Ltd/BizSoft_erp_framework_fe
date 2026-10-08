/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app_config.dart
 Purpose      : application configuration model.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsAppConfig {
  const BsAppConfig({
    required this.baseUrl,
    this.appName = 'BizSoft',
    this.apiTimeoutSeconds = 30,
  });

  final String baseUrl;
  final String appName;
  final int apiTimeoutSeconds;
}
