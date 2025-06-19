import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/appbar_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/bottom_sheet_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/checkbox_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/chip_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/elevated_button_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/outlined_button_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/text_field_theme.dart';
import 'package:flutter_application_1/src/ui/themes/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.orange,
      textTheme: TTextTheme.lightTextTheme,
      chipTheme: TChipTheme.lightChipTheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.orange,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme,
  );
}
