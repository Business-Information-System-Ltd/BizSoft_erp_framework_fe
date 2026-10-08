/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : partner_model.dart
 Purpose      : simple Partner placeholder model.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class PartnerModel {
  const PartnerModel({required this.id, required this.code, required this.name});

  final int id;
  final String code;
  final String name;
}
