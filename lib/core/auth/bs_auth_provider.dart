/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_auth_provider.dart
 Purpose      : Riverpod providers for auth and permission services.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bs_auth_service.dart';
import 'bs_auth_state.dart';
import 'bs_permission_provider.dart' as permission_provider;
import 'bs_permission_service.dart';

final bsAuthServiceProvider = Provider<BsAuthService>((ref) {
  return const BsAuthService();
});

final bsPermissionServiceProvider = Provider<BsPermissionService>((ref) {
  return BsPermissionService(
    ref.watch(permission_provider.bsCurrentUserProvider),
  );
});

final bsAuthStateProvider = FutureProvider<BsAuthState>((ref) {
  return ref.watch(bsAuthServiceProvider).currentState();
});
