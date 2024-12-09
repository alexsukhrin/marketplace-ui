import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Colors.blue;
  static const Color buttonColor = Color(0xFFFF9500);
  static const Color backgroundColor = Colors.white;

  static const Color witeText = Colors.white;
  static const Color headingTextColor = Color(0xFF212121);
  static const Color linkTextColor = Color(0xFFFF9500);

  static const Color activeBorderColor = Color(0xFFFFCC85);
  static const Color textFieldBackgroundColor = Color(0xFFF2F2F7);

  static const Color textFieldCounterColor = Color(0xFF949494);
  static const Color textFieldValidColor = Colors.green;

  static const Color textError = Colors.red;

  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
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
      scaffoldBackgroundColor: backgroundColor,
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
