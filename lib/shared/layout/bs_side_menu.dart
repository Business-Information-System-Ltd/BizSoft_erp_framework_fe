/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_side_menu.dart
 Purpose      : Collapsible role-sensitive left navigation menu for BizSoft shell.
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/bs_app_theme.dart';
import '../../core/menu/bs_menu_item.dart';
import '../../core/menu/bs_menu_provider.dart';
import '../../core/shell/bs_shell_state_provider.dart';

class BsSideMenu extends ConsumerWidget {
  const BsSideMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(bsVisibleMenuItemsProvider);
    final isExpanded = ref.watch(bsShellStateProvider).isSideMenuExpanded;
    final currentPath = GoRouterState.of(context).uri.path;
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      width: isExpanded
          ? BsAppTheme.sideMenuExpandedWidth
          : BsAppTheme.sideMenuCollapsedWidth,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor)),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 38,
              child: isExpanded
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Navigation',
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                    )
                  : IconButton(
                      tooltip: 'Expand menu',
                      icon: const Icon(
                        Icons.keyboard_double_arrow_right,
                        size: 20,
                      ),
                      onPressed: () => ref
                          .read(bsShellStateProvider.notifier)
                          .expandSideMenu(),
                    ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: isExpanded ? 6 : 4,
                  vertical: 4,
                ),
                children: [
                  for (final item in items)
                    if (isExpanded)
                      _ExpandedMenuEntry(item: item, currentPath: currentPath)
                    else
                      ..._collapsedEntries(context, item, currentPath),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _collapsedEntries(
    BuildContext context,
    BsMenuItem item,
    String currentPath,
  ) {
    if (!item.hasChildren) {
      return [_CollapsedMenuEntry(item: item, currentPath: currentPath)];
    }
    return [
      for (final child in item.children)
        _CollapsedMenuEntry(
          item: child,
          currentPath: currentPath,
          tooltipPrefix: item.title,
        ),
    ];
  }
}

class _ExpandedMenuEntry extends StatelessWidget {
  const _ExpandedMenuEntry({required this.item, required this.currentPath});

  final BsMenuItem item;
  final String currentPath;

  @override
  Widget build(BuildContext context) {
    if (item.hasChildren) {
      final selected = _hasSelectedChild(item);
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 1),
        child: ExpansionTile(
          initiallyExpanded: selected,
          leading: Icon(item.icon ?? Icons.folder_outlined, size: 20),
          title: Text(item.title, overflow: TextOverflow.ellipsis),
          children: [
            for (final child in item.children)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: _ExpandedMenuEntry(
                  item: child,
                  currentPath: currentPath,
                ),
              ),
          ],
        ),
      );
    }

    final selected = _isSelected(item.routePath, currentPath);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        selected: selected,
        selectedTileColor: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BsAppTheme.radius),
        ),
        leading: Icon(item.icon ?? Icons.chevron_right, size: 20),
        title: Text(item.title, overflow: TextOverflow.ellipsis),
        onTap: () => context.go(item.routePath),
      ),
    );
  }

  bool _hasSelectedChild(BsMenuItem item) {
    return item.children.any((child) {
      if (_isSelected(child.routePath, currentPath)) {
        return true;
      }
      return child.children.isNotEmpty && _hasSelectedChild(child);
    });
  }
}

class _CollapsedMenuEntry extends StatelessWidget {
  const _CollapsedMenuEntry({
    required this.item,
    required this.currentPath,
    this.tooltipPrefix,
  });

  final BsMenuItem item;
  final String currentPath;
  final String? tooltipPrefix;

  @override
  Widget build(BuildContext context) {
    final selected = _isSelected(item.routePath, currentPath);
    final tooltip = tooltipPrefix == null
        ? item.title
        : '$tooltipPrefix > ${item.title}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Tooltip(
        message: tooltip,
        waitDuration: const Duration(milliseconds: 400),
        child: Material(
          color: selected
              ? Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.75)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(BsAppTheme.radius),
          child: InkWell(
            borderRadius: BorderRadius.circular(BsAppTheme.radius),
            onTap: () => context.go(item.routePath),
            child: SizedBox(
              height: 40,
              child: Icon(
                item.icon ?? Icons.chevron_right,
                size: 21,
                color: selected ? Theme.of(context).colorScheme.primary : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

bool _isSelected(String routePath, String currentPath) {
  if (routePath == '/') {
    return currentPath == '/';
  }
  return currentPath == routePath || currentPath.startsWith('$routePath/');
}
