/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_menu_service.dart
 Purpose      : Mock menu service for the first role-sensitive side menu.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'package:flutter/material.dart';

import 'bs_menu_item.dart';

class BsMenuService {
  const BsMenuService();

  List<BsMenuItem> getMenuItems() {
    return const <BsMenuItem>[
      BsMenuItem(
        title: 'Dashboard',
        routePath: '/',
        icon: Icons.dashboard_outlined,
        permissionCode: 'DASHBOARD.VIEW',
      ),
      BsMenuItem(
        title: 'Common Setup',
        routePath: '/common/branches',
        icon: Icons.settings_applications_outlined,
        moduleCode: 'COMMON',
        children: <BsMenuItem>[
          BsMenuItem(
            title: 'Branch',
            routePath: '/common/branches',
            icon: Icons.account_tree_outlined,
            permissionCode: 'COMMON.BRANCH.VIEW',
          ),
          BsMenuItem(
            title: 'Department',
            routePath: '/common/departments',
            icon: Icons.groups_2_outlined,
            permissionCode: 'COMMON.DEPARTMENT.VIEW',
          ),
          BsMenuItem(
            title: 'Currency',
            routePath: '/common/currencies',
            icon: Icons.payments_outlined,
            permissionCode: 'COMMON.CURRENCY.VIEW',
          ),
          BsMenuItem(
            title: 'Partner Master',
            routePath: '/partners',
            icon: Icons.handshake_outlined,
            permissionCode: 'COMMON.PARTNER.VIEW',
          ),
          BsMenuItem(
            title: 'Supplier Entry',
            routePath: '/suppliers',
            icon: Icons.local_shipping_outlined,
            permissionCode: 'COMMON.SUPPLIER.VIEW',
          ),
        ],
      ),
      BsMenuItem(
        title: 'Samples',
        routePath: '/sample/material-widgets',
        icon: Icons.widgets_outlined,
        children: <BsMenuItem>[
          BsMenuItem(
            title: 'Material Widgets',
            routePath: '/sample/material-widgets',
            icon: Icons.widgets_outlined,
          ),
          BsMenuItem(
            title: 'Master Form',
            routePath: '/sample/master-form',
            icon: Icons.edit_note_outlined,
          ),
          BsMenuItem(
            title: 'Master List',
            routePath: '/sample/master-list',
            icon: Icons.table_rows_outlined,
          ),
          BsMenuItem(
            title: 'Lookup',
            routePath: '/sample/lookup',
            icon: Icons.search_outlined,
          ),
          BsMenuItem(
            title: 'Report',
            routePath: '/sample/report',
            icon: Icons.assessment_outlined,
          ),
        ],
      ),
      BsMenuItem(
        title: 'FAR',
        routePath: '/far/assets',
        icon: Icons.inventory_2_outlined,
        moduleCode: 'FAR',
        children: <BsMenuItem>[
          BsMenuItem(
            title: 'Asset Register',
            routePath: '/far/assets',
            icon: Icons.inventory_outlined,
            permissionCode: 'FAR.ASSET.VIEW',
          ),
          BsMenuItem(
            title: 'Asset Transactions',
            routePath: '/far/transactions',
            icon: Icons.swap_horiz_outlined,
            permissionCode: 'FAR.TRANSACTION.VIEW',
          ),
        ],
      ),
      BsMenuItem(
        title: 'Reports',
        routePath: '/far/reports/asset-register',
        icon: Icons.assessment_outlined,
        children: <BsMenuItem>[
          BsMenuItem(
            title: 'Asset Register Report',
            routePath: '/far/reports/asset-register',
            icon: Icons.description_outlined,
            permissionCode: 'FAR.REPORT.ASSET_REGISTER',
          ),
        ],
      ),
      BsMenuItem(
        title: 'Settings',
        routePath: '/settings/profile',
        icon: Icons.manage_accounts_outlined,
        permissionCode: 'SETTINGS.VIEW',
        children: <BsMenuItem>[
          BsMenuItem(
            title: 'User Profile',
            routePath: '/settings/profile',
            icon: Icons.person_outline,
            permissionCode: 'SETTINGS.VIEW',
          ),
          BsMenuItem(
            title: 'System Settings',
            routePath: '/settings/system',
            icon: Icons.tune_outlined,
            permissionCode: 'SETTINGS.VIEW',
          ),
        ],
      ),
    ];
  }
}
