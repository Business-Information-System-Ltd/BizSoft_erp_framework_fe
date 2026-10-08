/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_api_client_provider.dart
 Purpose      : Riverpod provider for BsApiClient.
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

import '../api/bs_api_client.dart';
import 'bs_dio_provider.dart';

final bsApiClientProvider = Provider<BsApiClient>((ref) {
  return BsApiClient(ref.watch(bsDioProvider));
});
