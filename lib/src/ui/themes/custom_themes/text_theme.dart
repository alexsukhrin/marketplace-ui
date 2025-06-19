import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._();
  static const Color neutralBlack = Color(0xFF000000);
  static const Color neutralWhite = Color(0xFFFFFFFF);
  static const Color neutralDarkGrey300 = Color(0xFF757575);
  static const Color neutralLightGrey300 = Color(0xFFB0B0B0);

  static TextTheme lightTextTheme = GoogleFonts.mulishTextTheme().copyWith(
    displayLarge: GoogleFonts.jura(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      height: 38 / 32,
      letterSpacing: -0.24,
      color: neutralBlack,
    ),
    titleLarge: GoogleFonts.mulish(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 30 / 24,
      letterSpacing: -0.24,
      color: neutralBlack,
    ),
    titleMedium: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: neutralBlack,
    ),
    titleSmall: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: neutralBlack,
    ),
    bodyLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      height: 20 / 16,
      letterSpacing: -0.24,
      color: neutralBlack,
    ),
    bodyMedium: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: neutralBlack,
    ),
    bodySmall: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: neutralDarkGrey300,
    ),
    labelLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 20 / 16,
      letterSpacing: 0,
      color: neutralWhite,
    ),
  );
  static TextTheme darkTextTheme = GoogleFonts.mulishTextTheme().copyWith(
    displayLarge: GoogleFonts.jura(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      height: 38 / 32,
      letterSpacing: -0.24,
      color: neutralWhite,
    ),
    titleLarge: GoogleFonts.mulish(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 30 / 24,
      letterSpacing: -0.24,
      color: neutralWhite,
    ),
    titleMedium: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: neutralLightGrey300,
    ),
    titleSmall: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: neutralWhite,
    ),
    bodyLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      height: 20 / 16,
      letterSpacing: -0.24,
      color: neutralLightGrey300,
    ),
    bodyMedium: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: neutralWhite,
    ),
    bodySmall: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: neutralLightGrey300,
    ),
    labelLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 20 / 16,
      letterSpacing: 0,
      color: neutralWhite,
    ),
  );
}
