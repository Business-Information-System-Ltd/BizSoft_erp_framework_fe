/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_user_context.dart
 Purpose      : Current user context model for shell permissions,
               allowed companies, and allowed legal entities.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - Legal Entity rights are temporarily mocked until real login/user-right
   integration is available.
 - allowedLegalEntityIds represents the Legal Entities the current user
   is allowed to access.
 - defaultLegalEntityId represents the Legal Entity selected when the
   application starts.

===============================================================================
*/

class BsUserContext {
  const BsUserContext({
    required this.userId,
    required this.displayName,
    required this.email,
    this.roles = const <String>[],
    this.permissions = const <String>{},
    this.allowedCompanyIds = const <String>[],
    this.allowedLegalEntityIds = const <int>[],
    this.defaultLegalEntityId,
  });

  final String userId;

  final String displayName;

  final String email;

  final List<String> roles;

  final Set<String> permissions;

 
  final List<String> allowedCompanyIds;


  final List<int> allowedLegalEntityIds;

  final int? defaultLegalEntityId;

  String get primaryRole {
    return roles.isEmpty ? 'User' : roles.first;
  }

  bool canAccessLegalEntity(int legalEntityId) {
    return allowedLegalEntityIds.contains(
      legalEntityId,
    );
  }
}