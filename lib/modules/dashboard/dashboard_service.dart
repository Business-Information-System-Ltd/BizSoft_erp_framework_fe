/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : dashboard_service.dart
 Purpose      : dashboard service placeholder.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class DashboardService {
  const DashboardService();

  Future<Map<String, int>> loadSummary() async {
    return const {'branches': 3, 'assets': 12, 'reports': 4};
  }
}
