import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.blue;
  static const Color activeButtonColor = Color(0xFFFF9500);
  static Color disabledButtonColor = const Color.fromRGBO(255, 204, 133, 1);
  static const Color backgroundColorWhite = Colors.white;

  static const Color blackText = Colors.black;
  static const Color witeText = Colors.white;
  static const Color headingTextColor = Color(0xFF212121);
  static const Color linkTextColor = Color(0xFFFF9500);
  static const Color hintTesxtGrey = Color(0xFF949494);

  static const Color activeBorderColor = Color(0xFFFFCC85);
  static const Color textFieldBackgroundColor = Color(0xFFF2F2F7);

  static const Color textFieldCounterColor = Color(0xFF949494);
  static const Color textFieldValidColor = Colors.green;

  static const Color textError = Colors.red;

  static const Color lightBodyColor = Color(0xFF3B3B3B);

  static const Color progressIndicatorInactive = Color(0xFFEFEFEF);
  static const Color progressIndicatorActive = Color(0xFFB6B6B6);

  static const Color successColor = Color.fromRGBO(159, 219, 77, 1);
  static const Color activeFieldBackgroundColor = Color(0xFFF6EADA);

  static const Color codeFieldBackgroundColor = Color(0xFFF2F2F7);
  static const Color splashColor = Color(0xFFFF9500);

  static ThemeData lightTheme() {
    return ThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontSize: 16),
      ),
      textTheme: GoogleFonts.mulishTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1.255,
            letterSpacing: -0.24,
          ),
          bodyMedium: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w300,
            height: 1.255,
            letterSpacing: -0.24,
          ),
          bodyLarge: TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w300,
            height: 1.255,
            letterSpacing: -0.24,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
      scaffoldBackgroundColor: backgroundColorWhite,
      appBarTheme: const AppBarTheme(
        // backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: witeText, fontSize: 20),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontSize: 16, color: Colors.white),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.blue,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
