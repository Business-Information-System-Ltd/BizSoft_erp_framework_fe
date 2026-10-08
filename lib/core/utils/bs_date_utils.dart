/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_date_utils.dart
 Purpose      : date parsing and formatting helpers.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:intl/intl.dart';

class BsDateUtils {
  const BsDateUtils._();

  static final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  static String formatDate(DateTime? value) {
    return value == null ? '' : _dateFormat.format(value);
  }

  static DateTime? parseDate(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    return DateTime.tryParse(value.trim());
  }
}
