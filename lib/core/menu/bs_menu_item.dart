/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_menu_item.dart
 Purpose      : Application shell menu item model.
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

class BsMenuItem {
  const BsMenuItem({
    required this.title,
    required this.routePath,
    this.icon,
    this.moduleCode,
    this.permissionCode,
    this.children = const <BsMenuItem>[],
  });

  final String title;
  final String routePath;
  final IconData? icon;
  final String? moduleCode;
  final String? permissionCode;
  final List<BsMenuItem> children;

  bool get hasChildren => children.isNotEmpty;
}
