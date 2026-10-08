/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_search_parser.dart
 Purpose      : simple parser for BizSoft search syntax.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_search_models.dart';

class BsSearchParser {
  const BsSearchParser._();

  static BsSearchRequest parse(String text) {
    final rules = <BsSearchRule>[];
    final parts = text.split(RegExp(r'\s+#(?:and|or)#\s+', caseSensitive: false));
    for (final part in parts) {
      final index = part.indexOf(':');
      if (index > 0) {
        rules.add(
          BsSearchRule(
            field: part.substring(0, index).trim(),
            operatorText: 'contains',
            value: part.substring(index + 1).trim(),
          ),
        );
      }
    }
    return BsSearchRequest(text: text, rules: rules);
  }
}
