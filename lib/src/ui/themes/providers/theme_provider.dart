import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode {
  light,
  dark,
}

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  ThemeNotifier() : super(AppThemeMode.light);

  void toggleTheme() {
    if (state == AppThemeMode.light) {
      state = AppThemeMode.dark;
    } else {
      state = AppThemeMode.light;
    }
  }

  void setLight() => state = AppThemeMode.light;
  void setDark() => state = AppThemeMode.dark;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>(
  (ref) => ThemeNotifier(),
);
