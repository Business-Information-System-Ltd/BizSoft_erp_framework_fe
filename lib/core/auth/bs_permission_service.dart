/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_permission_service.dart
 Purpose      : Permission checking service for shell and menu visibility.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_user_context.dart';

class BsPermissionService {
  const BsPermissionService(this._user);

  final BsUserContext _user;

  bool hasPermission(String? permissionCode) {
    if (permissionCode == null || permissionCode.trim().isEmpty) {
      return true;
    }
    return _user.permissions.contains(permissionCode);
  }

  bool can(BsUserContext user, String? permissionCode) {
    if (permissionCode == null || permissionCode.trim().isEmpty) {
      return true;
    }
    return user.permissions.contains(permissionCode);
  }
}