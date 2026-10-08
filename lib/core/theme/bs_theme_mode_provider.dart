/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_theme_mode_provider.dart
 Purpose      : Riverpod provider for application theme mode.
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
import 'package:flutter_riverpod/legacy.dart';

import 'bs_theme_service.dart';

final bsThemeServiceProvider = Provider<BsThemeService>((ref) {
  return const BsThemeService();
});

final bsThemeModeProvider = StateProvider<ThemeMode>((ref) {
  return ref.watch(bsThemeServiceProvider).defaultThemeMode();
});
