/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_dio_provider.dart
 Purpose      : Riverpod provider for configured Dio.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../api/bs_api_interceptor.dart';
import 'bs_app_config_provider.dart';

final bsDioProvider = Provider<Dio>((ref) {
  final config = ref.watch(bsAppConfigProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: Duration(seconds: config.apiTimeoutSeconds),
      receiveTimeout: Duration(seconds: config.apiTimeoutSeconds),
      headers: const {'Content-Type': 'application/json'},
    ),
  );
  dio.interceptors.add(BsApiInterceptor());
  return dio;
});
