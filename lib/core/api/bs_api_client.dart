/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_api_client.dart
 Purpose      : reusable Dio API client.
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

import 'bs_api_exception.dart';

class BsApiClient {
  const BsApiClient(this._dio);

  final Dio _dio;

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } catch (error) {
      throw _normalizeError(error);
    }
  }

  Future<dynamic> post(String path, {Object? data}) async {
    try {
      final response = await _dio.post<dynamic>(path, data: data);
      return response.data;
    } catch (error) {
      throw _normalizeError(error);
    }
  }

  Future<dynamic> put(String path, {Object? data}) async {
    try {
      final response = await _dio.put<dynamic>(path, data: data);
      return response.data;
    } catch (error) {
      throw _normalizeError(error);
    }
  }

  Future<dynamic> patch(String path, {Object? data}) async {
    try {
      final response = await _dio.patch<dynamic>(path, data: data);
      return response.data;
    } catch (error) {
      throw _normalizeError(error);
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await _dio.delete<dynamic>(path);
      return response.data;
    } catch (error) {
      throw _normalizeError(error);
    }
  }

  Future<List<int>> getBytes(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<List<int>>(
        path,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.bytes),
      );

      return response.data ?? <int>[];
    } catch (error) {
      throw _normalizeError(error);
    }
  }

  BsApiException _normalizeError(Object error) {
    if (error is DioException) {
      final response = error.response;
      final data = response?.data;
      final validationErrors = <String, List<String>>{};

      if (data is Map) {
        for (final entry in data.entries) {
          final value = entry.value;
          if (value is List) {
            validationErrors['${entry.key}'] = value
                .map((item) => '$item')
                .toList();
          } else {
            validationErrors['${entry.key}'] = ['$value'];
          }
        }
      }

      return BsApiException(
        message:
            response?.statusMessage ?? error.message ?? 'API request failed.',
        statusCode: response?.statusCode,
        validationErrors: validationErrors,
      );
    }

    return BsApiException(message: error.toString());
  }
}
