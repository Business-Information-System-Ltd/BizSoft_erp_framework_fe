/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : api_exception.dart
 Purpose      : *   Defines normalized API exception details for Partner UI requests.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class ApiException implements Exception {
  const ApiException({
    required this.message,
    this.statusCode,
    this.validationErrors = const <String, List<String>>{},
  });

  final String message;
  final int? statusCode;
  final Map<String, List<String>> validationErrors;

  bool get hasValidationErrors => validationErrors.isNotEmpty;

  @override
  String toString() => message;
}
