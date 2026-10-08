/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_action_button.dart
 Purpose      : base action button for BizSoft screens.
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

class BsActionButton extends StatelessWidget {
  const BsActionButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.primary = false,
    this.danger = false,
    this.permissionCode,
  });

  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool primary;
  final bool danger;
  final String? permissionCode;

  @override
  Widget build(BuildContext context) {
    final foreground = danger ? Theme.of(context).colorScheme.error : null;
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[Icon(icon, size: 18), const SizedBox(width: 6)],
        Text(label),
      ],
    );

    if (primary) {
      return FilledButton(onPressed: onPressed, child: child);
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: foreground == null ? null : OutlinedButton.styleFrom(foregroundColor: foreground),
      child: child,
    );
  }
}
