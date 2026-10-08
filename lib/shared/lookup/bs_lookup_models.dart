/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_lookup_models.dart
 Purpose      : lookup selection result models.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsLookupSelectionResult {
  const BsLookupSelectionResult({
    required this.id,
    required this.code,
    required this.displayText,
    this.rawData = const <String, dynamic>{},
  });

  final Object id;
  final String code;
  final String displayText;
  final Map<String, dynamic> rawData;
}
