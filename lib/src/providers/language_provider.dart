import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Enum для підтримуваних мов
enum AppLanguage {
  ukrainian('uk', 'UA', 'Українська'),
  english('en', 'ENG', 'English');

  const AppLanguage(this.languageCode, this.displayCode, this.displayName);

  final String languageCode;
  final String displayCode;
  final String displayName;

  Locale get locale => Locale(languageCode);
}

/// Notifier для управління мовою додатку
class LanguageNotifier extends StateNotifier<AppLanguage> {
  LanguageNotifier() : super(AppLanguage.ukrainian) {
    _loadLanguage();
  }

  static const String _languageKey = 'selected_language';

  /// Завантажує збережену мову з SharedPreferences
  Future<void> _loadLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_languageKey);

      if (languageCode != null) {
        final language = AppLanguage.values.firstWhere(
          (lang) => lang.languageCode == languageCode,
          orElse: () => AppLanguage.ukrainian,
        );
        state = language;
      }
    } catch (e) {
      // Якщо помилка завантаження, використовуємо українську за замовчуванням
      state = AppLanguage.ukrainian;
    }
  }

  /// Змінює мову додатку
  Future<void> changeLanguage(AppLanguage language) async {
    if (state == language) return;

    state = language;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, language.languageCode);
    } catch (e) {
      // Логуємо помилку, але не блокуємо зміну мови
      debugPrint('Помилка збереження мови: $e');
    }
  }

  /// Перемикає між українською та англійською
  Future<void> toggleLanguage() async {
    final newLanguage = state == AppLanguage.ukrainian
        ? AppLanguage.english
        : AppLanguage.ukrainian;
    await changeLanguage(newLanguage);
  }
}

/// Провайдер для доступу до поточної мови
final languageProvider = StateNotifierProvider<LanguageNotifier, AppLanguage>(
  (ref) => LanguageNotifier(),
);

/// Провайдер для поточної локалі
final localeProvider = Provider<Locale>((ref) {
  final language = ref.watch(languageProvider);
  return language.locale;
});
