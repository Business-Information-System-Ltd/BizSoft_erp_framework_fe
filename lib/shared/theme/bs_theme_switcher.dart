/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_theme_switcher.dart
 Purpose      : Header theme mode switcher.
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

import '../../core/theme/bs_theme_mode_provider.dart';

class BsThemeSwitcher extends ConsumerWidget {
  const BsThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(bsThemeModeProvider);
    return PopupMenuButton<ThemeMode>(
      tooltip: 'Theme',
      icon: Icon(_iconFor(themeMode), size: 22),
      onSelected: (value) => ref.read(bsThemeModeProvider.notifier).state = value,
      itemBuilder: (context) => const [
        PopupMenuItem(value: ThemeMode.light, child: Text('Light')),
        PopupMenuItem(value: ThemeMode.dark, child: Text('Dark')),
        PopupMenuItem(value: ThemeMode.system, child: Text('System')),
      ],
    );
  }

  IconData _iconFor(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => Icons.light_mode_outlined,
      ThemeMode.dark => Icons.dark_mode_outlined,
      ThemeMode.system => Icons.brightness_auto_outlined,
    };
  }
}