/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_report_date_models.dart
 Purpose      : report date filter models.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
enum BsReportDatePreset {
  today,
  yesterday,
  thisWeek,
  thisMonth,
  previousMonth,
  last3Months,
  last6Months,
  thisYear,
  specificDateRange,
}

extension BsReportDatePresetLabel on BsReportDatePreset {
  String get label => switch (this) {
        BsReportDatePreset.today => 'Today',
        BsReportDatePreset.yesterday => 'Yesterday',
        BsReportDatePreset.thisWeek => 'This Week',
        BsReportDatePreset.thisMonth => 'This Month',
        BsReportDatePreset.previousMonth => 'Previous Month',
        BsReportDatePreset.last3Months => 'Last 3 Months',
        BsReportDatePreset.last6Months => 'Last 6 Months',
        BsReportDatePreset.thisYear => 'This Year',
        BsReportDatePreset.specificDateRange => 'Specific Date Range',
      };
}

class BsDateRangeFilterResult {
  const BsDateRangeFilterResult({
    required this.preset,
    required this.fromDate,
    required this.toDate,
  });

  final BsReportDatePreset preset;
  final DateTime fromDate;
  final DateTime toDate;
}
