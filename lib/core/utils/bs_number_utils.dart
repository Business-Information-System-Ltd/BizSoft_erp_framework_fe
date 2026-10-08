/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_number_utils.dart
 Purpose      : number parsing and formatting helpers.
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

class BsNumberUtils {
  const BsNumberUtils._();

  static String formatAmount(num? value, {int decimalDigits = 2}) {
    if (value == null) {
      return '';
    }
    return NumberFormat.decimalPatternDigits(decimalDigits: decimalDigits).format(value);
  }

  static num? parseNumber(String value) {
    return num.tryParse(value.replaceAll(',', '').trim());
  }
}
