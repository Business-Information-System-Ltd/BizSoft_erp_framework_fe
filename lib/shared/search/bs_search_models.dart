/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_search_models.dart
 Purpose      : search box models.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
enum BsSearchTriggerMode { buttonPress, textChange }

class BsSearchRule {
  const BsSearchRule({
    required this.field,
    required this.operatorText,
    required this.value,
  });

  final String field;
  final String operatorText;
  final String value;
}

class BsSearchRequest {
  const BsSearchRequest({
    required this.text,
    this.rules = const <BsSearchRule>[],
  });

  final String text;
  final List<BsSearchRule> rules;
}

class BsSearchPopupItem {
  const BsSearchPopupItem({
    required this.label,
    required this.insertText,
    this.description,
  });

  final String label;
  final String insertText;
  final String? description;
}
