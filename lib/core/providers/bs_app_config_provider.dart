/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app_config_provider.dart
 Purpose      : Riverpod provider for app configuration.
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

import '../../app/bs_app_config.dart';
import '../../app/bs_app_constants.dart';

final bsAppConfigProvider = Provider<BsAppConfig>((ref) {
  const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: BsAppConstants.defaultApiBaseUrl,
  );
  return const BsAppConfig(baseUrl: baseUrl);
});
