import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  TTextTheme._();

  static TextTheme lightTextTheme = GoogleFonts.mulishTextTheme().copyWith(
    displayLarge: GoogleFonts.jura(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      height: 38 / 32,
      letterSpacing: -0.24,
      color: TColors.black,
    ),
    titleLarge: GoogleFonts.mulish(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 30 / 24,
      letterSpacing: -0.24,
      color: TColors.black,
    ),
    titleMedium: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: TColors.black,
    ),
    titleSmall: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: TColors.black,
    ),
    bodyLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      height: 20 / 16,
      letterSpacing: -0.24,
      color: TColors.black,
    ),
    bodyMedium: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: TColors.black,
    ),
    bodySmall: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: TColors.greyMedium,
    ),
    labelLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 20 / 16,
      letterSpacing: 0,
      color: TColors.white,
    ),
  );
  static TextTheme darkTextTheme = GoogleFonts.mulishTextTheme().copyWith(
    displayLarge: GoogleFonts.jura(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      height: 38 / 32,
      letterSpacing: -0.24,
      color: TColors.white,
    ),
    titleLarge: GoogleFonts.mulish(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 30 / 24,
      letterSpacing: -0.24,
      color: TColors.white,
    ),
    titleMedium: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: TColors.greyMediumLight,
    ),
    titleSmall: GoogleFonts.mulish(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 25 / 20,
      letterSpacing: -0.24,
      color: TColors.white,
    ),
    bodyLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      height: 20 / 16,
      letterSpacing: -0.24,
      color: TColors.greyMediumLight,
    ),
    bodyMedium: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: TColors.white,
    ),
    bodySmall: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 20 / 16,
      letterSpacing: 0,
      color: TColors.greyMediumLight,
    ),
    labelLarge: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      height: 20 / 16,
      letterSpacing: 0,
      color: TColors.white,
    ),
  );
}
