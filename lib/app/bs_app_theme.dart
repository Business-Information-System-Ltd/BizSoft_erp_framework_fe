/*
===============================================================================
 BizSoft Frontend Framework
===============================================================================

 File Name    : bs_app_theme.dart
 Purpose      : Professional compact ERP themes for BizSoft framework.
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

class BsAppTheme {
  const BsAppTheme._();

  static const Color primaryBlue = Color(0xFF1F5EA8);
  static const Color lightBackground = Color(0xFFF3F5F8);
  static const Color lightPanel = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFD6DAE1);
  static const Color darkBackground = Color(0xFF151922);
  static const Color darkPanel = Color(0xFF202631);
  static const Color darkBorder = Color(0xFF343B48);

  static const double radius = 3;
  static const double sectionRadius = 3;
  static const double buttonRadius = 3;
  static const double inputRadius = 3;
  static const double headerHeight = 60;
  static const double footerHeight = 34;
  static const double sideMenuExpandedWidth = 240;
  static const double sideMenuCollapsedWidth = 60;
  static const double pagePadding = 14;
  static const double compactGap = 8;

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: primaryBlue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDCEBFF),
      onPrimaryContainer: Color(0xFF0E315E),
      secondary: Color(0xFF52677F),
      surface: lightPanel,
      onSurface: Color(0xFF20242B),
      surfaceContainerLowest: lightBackground,
      surfaceContainerLow: Color(0xFFF8FAFC),
      surfaceContainerHighest: Color(0xFFE8EDF4),
      outline: Color(0xFF9EA7B3),
      outlineVariant: lightBorder,
      error: Color(0xFFB3261E),
    );
    return _baseTheme(colorScheme, Brightness.light);
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: Color(0xFF8AB8FF),
      onPrimary: Color(0xFF0A2547),
      primaryContainer: Color(0xFF183E6E),
      onPrimaryContainer: Color(0xFFD7E8FF),
      secondary: Color(0xFFB5C8DD),
      surface: darkPanel,
      onSurface: Color(0xFFE7EBF0),
      surfaceContainerLowest: darkBackground,
      surfaceContainerLow: Color(0xFF1B212B),
      surfaceContainerHighest: Color(0xFF2A3240),
      outline: Color(0xFF8D98A6),
      outlineVariant: darkBorder,
      error: Color(0xFFFFB4AB),
    );
    return _baseTheme(colorScheme, Brightness.dark);
  }

  static ThemeData _baseTheme(ColorScheme colorScheme, Brightness brightness) {
    final radiusBorder = BorderRadius.circular(radius);
    final outlineBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(inputRadius),
      borderSide: BorderSide(color: colorScheme.outlineVariant),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.compact,
      scaffoldBackgroundColor: colorScheme.surfaceContainerLowest,
      fontFamily: 'Segoe UI',
      dividerColor: colorScheme.outlineVariant,
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 14),
        bodyMedium: TextStyle(fontSize: 13),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: outlineBorder,
        enabledBorder: outlineBorder,
        focusedBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.primary, width: 1.4),
        ),
        errorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: outlineBorder.copyWith(
          borderSide: BorderSide(color: colorScheme.error, width: 1.4),
        ),
        isDense: true,
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(sectionRadius),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: radiusBorder),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: radiusBorder),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radiusBorder),
          side: BorderSide(color: colorScheme.outlineVariant),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radiusBorder),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radiusBorder),
          visualDensity: VisualDensity.compact,
        ),
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        minLeadingWidth: 24,
        horizontalTitleGap: 10,
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 2,
        color: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radiusBorder,
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      expansionTileTheme: ExpansionTileThemeData(
        tilePadding: const EdgeInsets.symmetric(horizontal: 10),
        childrenPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: radiusBorder),
        collapsedShape: RoundedRectangleBorder(borderRadius: radiusBorder),
      ),
    );
  }
}
