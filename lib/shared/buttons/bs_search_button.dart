/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_search_button.dart
 Purpose      : standard search/run button.
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

class BsSearchButton extends StatelessWidget {
  const BsSearchButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BsActionButton(label: 'Search', icon: Icons.search, primary: true, onPressed: onPressed);
  }
}
