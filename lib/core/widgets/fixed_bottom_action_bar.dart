/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : fixed_bottom_action_bar.dart
 Purpose      : Fixed bottom-right action bar for ERP form commit actions.
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

class FixedBottomActionBar extends StatelessWidget {
  const FixedBottomActionBar({
    super.key,
    this.cancelButton,
    this.saveButton,
    this.actions = const <Widget>[],
    this.isLoading = false,
  });

  final Widget? cancelButton;
  final Widget? saveButton;
  final List<Widget> actions;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final children = <Widget>[
      if (cancelButton != null) cancelButton!,
      ...actions,
      if (saveButton != null) saveButton!,
    ];

    return Material(
      color: theme.colorScheme.surface,
      elevation: 2,
      child: SafeArea(
        top: false,
        minimum: const EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: theme.colorScheme.outlineVariant),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: IgnorePointer(
                ignoring: isLoading,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 120),
                  opacity: isLoading ? 0.72 : 1,
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 8,
                    children: children,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
