/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_menu_provider.dart
 Purpose      : Riverpod providers for menu items and permission-filtered visible menu.
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

import '../auth/bs_permission_provider.dart';
import 'bs_menu_item.dart';
import 'bs_menu_service.dart';

final bsMenuServiceProvider = Provider<BsMenuService>((ref) {
  return const BsMenuService();
});

final bsMenuItemsProvider = Provider<List<BsMenuItem>>((ref) {
  return ref.watch(bsMenuServiceProvider).getMenuItems();
});

final bsVisibleMenuItemsProvider = Provider<List<BsMenuItem>>((ref) {
  final permissionService = ref.watch(bsPermissionServiceProvider);
  final items = ref.watch(bsMenuItemsProvider);

  BsMenuItem? filterItem(BsMenuItem item) {
    final visibleChildren = item.children.map(filterItem).whereType<BsMenuItem>().toList();
    final allowed = permissionService.hasPermission(item.permissionCode);
    if (!allowed && visibleChildren.isEmpty) {
      return null;
    }
    return BsMenuItem(
      title: item.title,
      routePath: visibleChildren.isNotEmpty ? visibleChildren.first.routePath : item.routePath,
      icon: item.icon,
      moduleCode: item.moduleCode,
      permissionCode: item.permissionCode,
      children: visibleChildren,
    );
  }

  return items.map(filterItem).whereType<BsMenuItem>().toList();
});