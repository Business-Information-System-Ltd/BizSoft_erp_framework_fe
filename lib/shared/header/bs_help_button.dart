/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_help_button.dart
 Purpose      : Header help button and simple help menus.
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

class BsHelpButton extends StatelessWidget {
  const BsHelpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: 'Help',
      icon: const Icon(Icons.help_outline, size: 22),
      onSelected: (value) => _showHelp(context, value),
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'guide', child: Text('User Guide')),
        PopupMenuItem(value: 'shortcuts', child: Text('Keyboard Shortcuts')),
        PopupMenuItem(value: 'about', child: Text('About BizSoft')),
      ],
    );
  }

  Future<void> _showHelp(BuildContext context, String value) async {
    final title = switch (value) {
      'guide' => 'User Guide',
      'shortcuts' => 'Keyboard Shortcuts',
      _ => 'About BizSoft',
    };
    final message = switch (value) {
      'guide' => 'Use the side menu to open modules. Page actions are upper-right. Save and Cancel are lower-right.',
      'shortcuts' => 'Keyboard shortcuts will be listed here when enabled.',
      _ => 'BizSoft Frontend Framework ERP shell.',
    };
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [FilledButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))],
      ),
    );
  }
}