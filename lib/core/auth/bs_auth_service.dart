/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_auth_service.dart
 Purpose      : authentication service placeholder.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'bs_auth_state.dart';

class BsAuthService {
  const BsAuthService();

  Future<BsAuthState> currentState() async {
    return const BsAuthState();
  }
}
