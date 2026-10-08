/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_company.dart
 Purpose      : Company model used by the application shell company selector.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsCompany {
  const BsCompany({
    required this.id,
    required this.code,
    required this.name,
    required this.timezone,
    required this.dateFormat,
    required this.timeFormat,
    required this.systemName,
    this.logoUrl,
    this.logoAssetPath,
    this.currentBusinessDate,
  });

  final String id;
  final String code;
  final String name;
  final String? logoUrl;
  final String? logoAssetPath;
  final String timezone;
  final String dateFormat;
  final String timeFormat;
  final String systemName;
  final DateTime? currentBusinessDate;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) {
      return code.substring(0, code.length > 2 ? 2 : code.length).toUpperCase();
    }
    return parts.take(2).map((part) => part.substring(0, 1).toUpperCase()).join();
  }
}