/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_audit_models.dart
 Purpose      : audit and workflow display models.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsAuditTrailItem {
  const BsAuditTrailItem({
    required this.action,
    required this.userName,
    required this.dateTime,
    this.remarks,
  });

  final String action;
  final String userName;
  final DateTime dateTime;
  final String? remarks;
}
