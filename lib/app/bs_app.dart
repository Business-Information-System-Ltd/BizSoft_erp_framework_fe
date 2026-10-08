/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app.dart
 Purpose      : Root Material application widget for BizSoft framework.
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

import '../core/providers/bs_router_provider.dart';
import '../core/theme/bs_theme_mode_provider.dart';
import 'bs_app_theme.dart';

class BsApp extends ConsumerWidget {
  const BsApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(bsRouterProvider);
    final themeMode = ref.watch(bsThemeModeProvider);

    return MaterialApp.router(
      title: 'BizSoft Frontend Framework',
      debugShowCheckedModeBanner: false,
      theme: BsAppTheme.lightTheme,
      darkTheme: BsAppTheme.darkTheme,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
