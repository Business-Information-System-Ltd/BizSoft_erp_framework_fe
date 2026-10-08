/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_lookup_column.dart
 Purpose      : lookup column definition.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsLookupColumn {
  const BsLookupColumn({
    required this.field,
    required this.title,
    this.width = 160,
  });

  final String field;
  final String title;
  final double width;
}
