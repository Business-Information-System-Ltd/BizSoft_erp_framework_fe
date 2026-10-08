/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_master_entry_page.dart
 Purpose      : Reusable ERP master entry page layout with basic info and detail areas.
 Company      : BizSoft Systems
 Created By   : BizSoft Frontend Framework Team

 Notes        :
 - This is a common framework widget or source file.
 - Do not add FAR, HR, Partner, or module-specific business logic here unless this file is inside a module folder.
 - Use Theme.of(context) to support future theme changes where UI styling is needed.
 - Business screens should use BizSoft reusable widgets instead of raw Flutter widgets.

===============================================================================
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../app/bs_app_theme.dart';
import '../../core/widgets/screen_context_panel.dart';
import '../../core/widgets/section_header_with_status.dart';
import '../feedback/bs_loading_overlay.dart';
import '../status/bs_status_badge.dart';
import 'bs_page.dart';
import 'bs_page_header.dart';

class BsMasterEntryRouteMeta {
  const BsMasterEntryRouteMeta({
    required this.title,
    this.subtitle,
    this.moduleCode,
    this.screenCode,
    this.recordId,
    this.breadcrumb,
    this.status,
  });

  final String title;
  final String? subtitle;
  final String? moduleCode;
  final String? screenCode;
  final String? recordId;
  final Widget? breadcrumb;
  final Widget? status;
}

class BsMasterEntryPage extends StatelessWidget {
  const BsMasterEntryPage({
    super.key,
    required this.routeMeta,
    this.pageActions,
    required this.basicInfo,
    required this.detailContent,
    this.formActions,
    this.isLoading = false,
    this.isDirty = false,
    this.basicInfoTitle = 'Basic Information',
    this.basicInfoStatus,
    this.basicInfoContextItems = const <ScreenContextItem>[],
    this.onSaveShortcut,
    this.onCancelShortcut,
  });

  final BsMasterEntryRouteMeta routeMeta;
  final List<Widget>? pageActions;
  final Widget basicInfo;
  final Widget detailContent;
  final Widget? formActions;
  final bool isLoading;
  final bool isDirty;
  final String basicInfoTitle;
  final String? basicInfoStatus;
  final List<ScreenContextItem> basicInfoContextItems;
  final FutureOr<void> Function()? onSaveShortcut;
  final FutureOr<void> Function()? onCancelShortcut;

  @override
  Widget build(BuildContext context) {
    return BsPage(
      title: routeMeta.title,
      breadcrumb: routeMeta.breadcrumb,
      header: BsPageHeader(
        title: routeMeta.title,
        subtitle: routeMeta.subtitle,
        status: _buildStatus(context),
        actions: pageActions,
      ),
      body: _ShortcutScope(
        onSave: onSaveShortcut,
        onCancel: onCancelShortcut,
        child: BsLoadingOverlay(
          isLoading: isLoading,
          child: BsFormDirtyGuardScope(
            isDirty: isDirty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _BsBasicInfoPanel(
                  title: basicInfoTitle,
                  status: basicInfoStatus,
                  contextItems: basicInfoContextItems,
                  child: basicInfo,
                ),
                const SizedBox(height: 8),
                Expanded(child: detailContent),
              ],
            ),
          ),
        ),
      ),
      footer: formActions,
    );
  }

  Widget? _buildStatus(BuildContext context) {
    if (routeMeta.status == null && !isDirty) {
      return null;
    }

    return Wrap(
      spacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        if (routeMeta.status != null) routeMeta.status!,
        if (isDirty)
          const BsStatusBadge(text: 'Unsaved', type: BsStatusType.warning),
      ],
    );
  }
}

class _BsBasicInfoPanel extends StatelessWidget {
  const _BsBasicInfoPanel({
    required this.title,
    required this.child,
    this.status,
    this.contextItems = const <ScreenContextItem>[],
  });

  final String title;
  final String? status;
  final List<ScreenContextItem> contextItems;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(BsAppTheme.sectionRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionHeaderWithStatus(
              title: title,
              status: status,
              showContextIcon: contextItems.isNotEmpty,
              onContextPressed: contextItems.isEmpty
                  ? null
                  : () => ScreenContextPanel.show(
                      context,
                      title: '$title Context',
                      items: contextItems,
                    ),
            ),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

class _SaveFormIntent extends Intent {
  const _SaveFormIntent();
}

class _CancelFormIntent extends Intent {
  const _CancelFormIntent();
}

class _ShortcutScope extends StatelessWidget {
  const _ShortcutScope({required this.child, this.onSave, this.onCancel});

  final Widget child;
  final FutureOr<void> Function()? onSave;
  final FutureOr<void> Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      child: Shortcuts(
        shortcuts: const <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.keyS, control: true):
              _SaveFormIntent(),
          SingleActivator(LogicalKeyboardKey.escape): _CancelFormIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            _SaveFormIntent: CallbackAction<_SaveFormIntent>(
              onInvoke: (_) {
                onSave?.call();
                return null;
              },
            ),
            _CancelFormIntent: CallbackAction<_CancelFormIntent>(
              onInvoke: (_) {
                onCancel?.call();
                return null;
              },
            ),
          },
          child: child,
        ),
      ),
    );
  }
}

class BsFormDirtyGuardScope extends InheritedWidget {
  const BsFormDirtyGuardScope({
    super.key,
    required this.isDirty,
    required super.child,
  });

  final bool isDirty;

  static BsFormDirtyGuardScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BsFormDirtyGuardScope>();
  }

  static bool isDirtyOf(BuildContext context) {
    return maybeOf(context)?.isDirty ?? false;
  }

  @override
  bool updateShouldNotify(BsFormDirtyGuardScope oldWidget) {
    return oldWidget.isDirty != isDirty;
  }
}

class BsFormDirtyGuard extends StatelessWidget {
  const BsFormDirtyGuard({
    super.key,
    required this.isDirty,
    required this.child,
  });

  final bool isDirty;
  final Widget child;

  static Future<bool> confirmDiscard(
    BuildContext context, {
    required bool isDirty,
  }) async {
    if (!isDirty) {
      return true;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unsaved changes'),
        content: const Text(
          'You have unsaved changes. Do you want to discard changes?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Stay'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Integrate this guard with global go_router redirects, menu changes,
    // company switching, and record-to-record navigation when shell navigation
    // lifecycle hooks are finalized. First version exposes confirmDiscard for
    // page actions such as Cancel, New, and open-record.
    return BsFormDirtyGuardScope(isDirty: isDirty, child: child);
  }
}
