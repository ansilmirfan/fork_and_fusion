import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  //--------primary theme--------------
  static var primaryTheme = ThemeData(
    colorScheme: colorScheme,
    appBarTheme: appBarTheme,
    textTheme: textTheme,
    filledButtonTheme: filledButtonTheme,
  );
  //-------------color theme-----------------
  static const colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFFF6B01),
    onPrimary: Colors.white,
    secondary: Color.fromARGB(255, 234, 148, 88),
    onSecondary: Colors.white,
    tertiary: Colors.white,
    onTertiary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    surface: Color.fromARGB(255, 239, 239, 239),
    onSurface: Color(0xFF121212),
    inversePrimary: Colors.grey,
  );
  //-------------appbar theme----------------
  static var appBarTheme = AppBarTheme(
    backgroundColor: const Color(0xFFFF6B01),
    foregroundColor: Colors.white,
    centerTitle: true,
    titleTextStyle: GoogleFonts.itim(fontSize: 25),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  );
  //------------------text theme-------------
  static var baseTextStyle = GoogleFonts.itim(color: Colors.black);

  static var textTheme = TextTheme(
    bodyMedium: baseTextStyle.copyWith(fontSize: 17),
    bodyLarge: baseTextStyle,
    bodySmall: baseTextStyle,
    displayLarge: baseTextStyle,
    displayMedium: baseTextStyle,
    displaySmall: baseTextStyle,
    headlineLarge: baseTextStyle,
    headlineMedium: baseTextStyle,
    headlineSmall: baseTextStyle,
    labelSmall: baseTextStyle,
    titleMedium: baseTextStyle,
    titleSmall: baseTextStyle,
    labelLarge: baseTextStyle.copyWith(
      color: Colors.white,
    ),
    labelMedium: baseTextStyle.copyWith(
      color: Colors.grey,
    ),
    titleLarge: baseTextStyle.copyWith(
      color: Colors.black,
      fontSize: 30,
    ),
  );
//---------filled button -----------
  static const filledButtonTheme = FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(
        Color(0xFFFF6B01),
      ),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      overlayColor: WidgetStatePropertyAll(Colors.grey),
    ),
  );
}
