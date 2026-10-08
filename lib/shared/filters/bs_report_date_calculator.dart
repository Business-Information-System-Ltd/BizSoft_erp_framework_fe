/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_report_date_calculator.dart
 Purpose      : calculates concrete report date ranges.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_report_date_models.dart';

class BsReportDateRangeCalculator {
  const BsReportDateRangeCalculator._();

  static BsDateRangeFilterResult calculate(BsReportDatePreset preset, {DateTime? today}) {
    final now = today ?? DateTime.now();
    final current = DateTime(now.year, now.month, now.day);
    final result = switch (preset) {
      BsReportDatePreset.today => (current, current),
      BsReportDatePreset.yesterday => (current.subtract(const Duration(days: 1)), current.subtract(const Duration(days: 1))),
      BsReportDatePreset.thisWeek => (current.subtract(Duration(days: current.weekday - 1)), current),
      BsReportDatePreset.thisMonth => (DateTime(current.year, current.month), current),
      BsReportDatePreset.previousMonth => (DateTime(current.year, current.month - 1), DateTime(current.year, current.month, 0)),
      BsReportDatePreset.last3Months => (DateTime(current.year, current.month - 2), current),
      BsReportDatePreset.last6Months => (DateTime(current.year, current.month - 5), current),
      BsReportDatePreset.thisYear => (DateTime(current.year), current),
      BsReportDatePreset.specificDateRange => (current, current),
    };
    return BsDateRangeFilterResult(preset: preset, fromDate: result.$1, toDate: result.$2);
  }
}
