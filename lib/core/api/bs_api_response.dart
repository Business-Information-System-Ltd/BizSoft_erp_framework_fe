/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_api_response.dart
 Purpose      : standard API response wrapper.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsApiResponse<T> {
  const BsApiResponse({
    required this.data,
    this.message,
    this.success = true,
  });

  final T data;
  final String? message;
  final bool success;
}
