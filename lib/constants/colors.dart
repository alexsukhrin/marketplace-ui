import 'package:flutter/material.dart';

class TColors {
  TColors._();

  static const LinearGradient orangeGradient = LinearGradient(
    colors: [
      orange,
      orangeLight,
    ],
    stops: [0.0, 0.8],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Color orangeExtraLight = Color(0xFFFFFBF4);
  static const Color orangeLight = Color(0xFFFFCC85);
  static const Color orange = Color(0xFFFF9500);

  static const Color redLight = Color(0xFFFF5454);
  static const Color red = Color(0xFFE95050);

  static const Color greenSuccess = Color(0xFF9FDB4D);

  static const Color white = Color(0xFFFFFFFF);

  static const Color greyExtraLight = Color(0xFFF7F7F7);
  static const Color greyLighter = Color(0xFFF4F4F4);
  static const Color greyLight = Color(0xFFF2F2F7);
  static const Color grey = Color(0xFFEFEFEF);

  static const Color greyMediumLight = Color(0xFFB0B0B0);
  static const Color greyMedium = Color(0xFF757575);

  static const Color greyDark = Color(0xFFB6B6B6);
  static const Color greyDarker = Color(0xFF949494);
  static const Color greyDarkest = Color(0xFF464646);
  static const Color greyUltraDark = Color(0xFF3B3B3B);

  static const Color black = Color(0xFF000000);

  static const Color turquoiseLight = Color(0xFFC8E1E5);
  static const Color turquoise = Color(0xFFBED7DC);

  static const Color greenLight = Color(0xFFC2D0AF);
  static const Color greenExtraLight = Color(0xFFCCD9BD);

  static const Color beige = Color(0xFFECDFCC);
  static const Color beigeLight = Color(0xFFF6EADA);

  static const Color blue = Color(0xFF0099FF);
  static const Color blueGoogle = Color(0xFF4285F4);
  static const Color blueDark = Color(0xFF1873EB);

  static const Color purple = Color(0xFF7B61FF);
  static const Color charcoal = Color(0xFF222222);
  static const Color redAccent = Color(0xFFFC5555);
  static const Color greenAccent = Color(0xFF29CC6A);
}
