/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : api_client.dart
 Purpose      : *   Configures Dio and normalizes API errors for the Partner UI.
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

import 'api_exception.dart';

class ApiClient {
  ApiClient({
    required String baseUrl,
    Dio? dio,
  }) : dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 20),
                receiveTimeout: const Duration(seconds: 30),
                headers: {'Accept': 'application/json'},
              ),
            );

  final Dio dio;

  ApiException normalizeError(Object error) {
    if (error is DioException) {
      final response = error.response;
      final data = response?.data;
      final validationErrors = <String, List<String>>{};

      if (data is Map<String, dynamic>) {
        for (final entry in data.entries) {
          final value = entry.value;
          if (value is List) {
            validationErrors[entry.key] = value.map((item) => '$item').toList();
          } else {
            validationErrors[entry.key] = ['$value'];
          }
        }
      }

      return ApiException(
        message: response?.statusMessage ?? error.message ?? 'API request failed.',
        statusCode: response?.statusCode,
        validationErrors: validationErrors,
      );
    }

    return ApiException(message: error.toString());
  }
}
