/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_form_session_key.dart
 Purpose      : Unique form session key for in-memory and future persisted drafts.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
class BsFormSessionKey {
  const BsFormSessionKey({
    required this.companyId,
    required this.userId,
    required this.moduleCode,
    required this.screenCode,
    this.recordId,
  });

  final String companyId;
  final String userId;
  final String moduleCode;
  final String screenCode;
  final String? recordId;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is BsFormSessionKey &&
            other.companyId == companyId &&
            other.userId == userId &&
            other.moduleCode == moduleCode &&
            other.screenCode == screenCode &&
            other.recordId == recordId;
  }

  @override
  int get hashCode {
    return Object.hash(companyId, userId, moduleCode, screenCode, recordId);
  }

  @override
  String toString() {
    return [
      companyId,
      userId,
      moduleCode,
      screenCode,
      recordId ?? 'new',
    ].join(':');
  }
}
