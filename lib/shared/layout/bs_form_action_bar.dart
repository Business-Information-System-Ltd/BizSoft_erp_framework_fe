/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_form_action_bar.dart
 Purpose      : Lower-right form commit/cancel action bar for BizSoft forms.
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

import '../../core/widgets/fixed_bottom_action_bar.dart';

class BsFormActionBar extends StatelessWidget {
  const BsFormActionBar({
    super.key,
    this.cancelButton,
    this.saveButton,
    this.actions = const <Widget>[],
    this.sticky = false,
    this.isLoading = false,
  });

  final Widget? cancelButton;
  final Widget? saveButton;
  final List<Widget> actions;
  final bool isLoading;

  /// Reserved for future sticky footer behavior inside nested scrollable forms.
  final bool sticky;

  @override
  Widget build(BuildContext context) {
    return FixedBottomActionBar(
      cancelButton: cancelButton,
      saveButton: saveButton,
      actions: actions,
      isLoading: isLoading,
    );
  }
}
