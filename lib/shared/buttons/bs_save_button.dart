/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_save_button.dart
 Purpose      : standard save button.
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

import 'bs_action_button.dart';

class BsSaveButton extends StatelessWidget {
  const BsSaveButton({super.key, this.onPressed, this.permissionCode});

  final VoidCallback? onPressed;
  final String? permissionCode;

  @override
  Widget build(BuildContext context) {
    return BsActionButton(
      label: 'Save',
      icon: Icons.save,
      primary: true,
      onPressed: onPressed,
      permissionCode: permissionCode,
    );
  }
}
