/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_format_utils.dart
 Purpose      : convenience formatting facade.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_date_utils.dart';
import 'bs_number_utils.dart';

class BsFormatUtils {
  const BsFormatUtils._();

  static String date(DateTime? value) => BsDateUtils.formatDate(value);

  static String amount(num? value) => BsNumberUtils.formatAmount(value);
}
