// /*
// ===============================================================================
//  BizSoft Frontend Framework
// ===============================================================================

//  File Name    : bs_permission_provider.dart
//  Purpose      : Riverpod providers for mock user context and permission service.
//  Company      : BizSoft Systems
//  Created By   : BizSoft Frontend Framework Team

//  Notes        :
//  - This is a common framework widget or source file.
//  - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
//  - Use Theme.of(context) to support future theme changes where UI styling is needed.
//  - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

// ===============================================================================
// */
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'bs_permission_service.dart';
// import 'bs_user_context.dart';

// final bsCurrentUserProvider = Provider<BsUserContext>((ref) {
//   return const BsUserContext(
//     userId: 'u001',
//     displayName: 'Ye Yint Win',
//     email: 'yeyint.win@gmail.com',
//     roles: ['Admin', 'Consultant'],
//     allowedCompanyIds: ['BIZSOFT', 'DEMO'],
//     permissions: {
//       'DASHBOARD.VIEW',
//       'COMMON.BRANCH.VIEW',
//       'COMMON.DEPARTMENT.VIEW',
//       'COMMON.CURRENCY.VIEW',
//       'COMMON.PARTNER.VIEW',
//       'COMMON.SUPPLIER.VIEW',
//       'FAR.ASSET.VIEW',
//       'FAR.TRANSACTION.VIEW',
//       'FAR.REPORT.ASSET_REGISTER',
//       'SETTINGS.VIEW',
//     },
//   );
// });

// final bsPermissionServiceProvider = Provider<BsPermissionService>((ref) {
//   return BsPermissionService(ref.watch(bsCurrentUserProvider));
// });


/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_permission_provider.dart
 Purpose      : Riverpod providers for mock user context and permissions.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - Real login is not available yet.
 - Therefore users and their Legal Entity rights are temporarily mocked here.
 - Replace this mock source with real login/user-right data later.
 - UI and business modules should NOT contain user-specific hard-coded logic.

 Mock Users
 ----------
 1. Ye Yint Win(u001)
    Allowed Legal Entities : 1, 3, 4 
    Default Legal Entity   : 1

 2. Sandar Win(u002)
    Allowed Legal Entities : 2, 5
    Default Legal Entity   : 2

  2. Aye Aye Win(u003)
    Allowed Legal Entities : 1, 4, 7
    Default Legal Entity   : 1

===============================================================================
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'bs_permission_service.dart';
import 'bs_user_context.dart';


final bsMockCurrentUserIdProvider =
    StateProvider<String>(
  (ref) {
    return 'u003';
  },
);

final bsMockUsersProvider =
    Provider<Map<String, BsUserContext>>(
  (ref) {
    final commonPermissions = <String>{
      'DASHBOARD.VIEW',
      'COMMON.BRANCH.VIEW',
      'COMMON.DEPARTMENT.VIEW',
      'COMMON.CURRENCY.VIEW',
      'COMMON.PARTNER.VIEW',
      'COMMON.SUPPLIER.VIEW',
      'FAR.ASSET.VIEW',
      'FAR.TRANSACTION.VIEW',
      'FAR.REPORT.ASSET_REGISTER',
      'SETTINGS.VIEW',
    };

    return {
    
      'u001': BsUserContext(
        userId: 'u001',
        displayName: 'Ye Yint Win',
        email: 'yeyint.win@gmail.com',
        roles: [
          'Admin',
          'Consultant',
        ],
        allowedCompanyIds: [
          'BIZSOFT',
          'DEMO',
        ],
        allowedLegalEntityIds: [
          1,
          3,
          4,
        ],
        defaultLegalEntityId: 1,
        permissions: commonPermissions,
      ),

      
      'u002': BsUserContext(
        userId: 'u002',
        displayName: 'Sandar Win',
        email: 'sandarwin@gmail.com',
        roles: [
          'User',
        ],
        allowedCompanyIds: [
          'BIZSOFT',
        ],
        allowedLegalEntityIds: [
          2,
          5,
        ],
        defaultLegalEntityId: 2,
        permissions: commonPermissions,
      ),
      'u003': BsUserContext(
        userId: 'u003',
        displayName: 'Aye Aye Win',
        email: 'ayeayewin@gmail.com',
        roles: [
          'Admin',
        ],
        allowedCompanyIds: [
          'BIZSOFT',
        ],
        allowedLegalEntityIds: [
          1,
          4,
          7,
        ],
        defaultLegalEntityId: 1,
        permissions: commonPermissions,
      ),
    };
  },
);

final bsCurrentUserProvider =
    Provider<BsUserContext>(
  (ref) {
    final currentUserId =
        ref.watch(
      bsMockCurrentUserIdProvider,
    );

    final users =
        ref.watch(
      bsMockUsersProvider,
    );

    return users[currentUserId] ??
        users.values.first;
  },
);

final bsPermissionServiceProvider =
    Provider<BsPermissionService>(
  (ref) {
    return BsPermissionService(
      ref.watch(
        bsCurrentUserProvider,
      ),
    );
  },
);