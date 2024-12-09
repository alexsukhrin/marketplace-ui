import 'package:flutter/material.dart';

class AppTheme {
  static const Color searchFieldBackground = Color(0xFFF4F4F4);
  static const Color yellowColor = Color(0xFF9500);

  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        labelStyle: TextStyle(fontSize: 16),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black, fontSize: 14),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF9500),
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16),
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
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
