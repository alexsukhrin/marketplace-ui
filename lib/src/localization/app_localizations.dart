import 'package:flutter/material.dart';

/// Клас для управління локалізацією додатку
class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  /// Отримує екземпляр AppLocalizations з контексту
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  /// Перевіряє чи підтримується локаль
  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  /// Список підтримуваних локалей
  static const List<Locale> supportedLocales = [
    Locale('uk'), // Українська
    Locale('en'), // Англійська
  ];

  // === ЗАГАЛЬНІ ===
  String get appName => _localizedValues[locale.languageCode]!['app_name']!;
  String get loading => _localizedValues[locale.languageCode]!['loading']!;
  String get error => _localizedValues[locale.languageCode]!['error']!;
  String get success => _localizedValues[locale.languageCode]!['success']!;
  String get cancel => _localizedValues[locale.languageCode]!['cancel']!;
  String get confirm => _localizedValues[locale.languageCode]!['confirm']!;
  String get ok => _localizedValues[locale.languageCode]!['ok']!;

  // === НАВІГАЦІЯ ===
  String get home => _localizedValues[locale.languageCode]!['home']!;
  String get about => _localizedValues[locale.languageCode]!['about']!;
  String get signUp => _localizedValues[locale.languageCode]!['sign_up']!;
  String get signIn => _localizedValues[locale.languageCode]!['sign_in']!;
  String get logout => _localizedValues[locale.languageCode]!['logout']!;

  // === ФОРМИ ===
  String get firstName => _localizedValues[locale.languageCode]!['first_name']!;
  String get lastName => _localizedValues[locale.languageCode]!['last_name']!;
  String get email => _localizedValues[locale.languageCode]!['email']!;
  String get password => _localizedValues[locale.languageCode]!['password']!;
  String get confirmPassword =>
      _localizedValues[locale.languageCode]!['confirm_password']!;
  String get register => _localizedValues[locale.languageCode]!['register']!;
  String get login => _localizedValues[locale.languageCode]!['login']!;

  // === ПОМИЛКИ ===
  String get invalidEmail =>
      _localizedValues[locale.languageCode]!['invalid_email']!;
  String get passwordsDoNotMatch =>
      _localizedValues[locale.languageCode]!['passwords_do_not_match']!;
  String get emailAlreadyExists =>
      _localizedValues[locale.languageCode]!['email_already_exists']!;
  String get validationError =>
      _localizedValues[locale.languageCode]!['validation_error']!;

  // === MARKETPLACE ===
  String get products => _localizedValues[locale.languageCode]!['products']!;
  String get categories =>
      _localizedValues[locale.languageCode]!['categories']!;
  String get cart => _localizedValues[locale.languageCode]!['cart']!;
  String get profile => _localizedValues[locale.languageCode]!['profile']!;

  // === ВІТАЛЬНИЙ ЕКРАН ===
  String get welcomeTitle =>
      _localizedValues[locale.languageCode]!['welcome_title']!;
  String get welcomeSubtitle =>
      _localizedValues[locale.languageCode]!['welcome_subtitle']!;
  String get getStarted =>
      _localizedValues[locale.languageCode]!['get_started']!;

  /// Словник перекладів
  static const Map<String, Map<String, String>> _localizedValues = {
    'uk': {
      // Загальні
      'app_name': 'SHUM',
      'loading': 'Завантаження...',
      'error': 'Помилка',
      'success': 'Успіх',
      'cancel': 'Скасувати',
      'confirm': 'Підтвердити',
      'ok': 'OK',

      // Навігація
      'home': 'Головна',
      'about': 'Про нас',
      'sign_up': 'Реєстрація',
      'sign_in': 'Вхід',
      'logout': 'Вихід',

      // Форми
      'first_name': 'Ім\'я',
      'last_name': 'Прізвище',
      'email': 'Електронна пошта',
      'password': 'Пароль',
      'confirm_password': 'Підтвердіть пароль',
      'register': 'Зареєструватися',
      'login': 'Увійти',

      // Помилки
      'invalid_email': 'Невірна електронна пошта',
      'passwords_do_not_match': 'Паролі не співпадають',
      'email_already_exists': 'Користувач з такою поштою вже існує',
      'validation_error': 'Помилка валідації',

      // Marketplace
      'products': 'Товари',
      'categories': 'Категорії',
      'cart': 'Кошик',
      'profile': 'Профіль',

      // Вітальний екран
      'welcome_title': 'Ласкаво просимо до SHUM',
      'welcome_subtitle': 'Ваш новий маркетплейс',
      'get_started': 'Почати',
    },
    'en': {
      // General
      'app_name': 'SHUM',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      'cancel': 'Cancel',
      'confirm': 'Confirm',
      'ok': 'OK',

      // Navigation
      'home': 'Home',
      'about': 'About',
      'sign_up': 'Sign Up',
      'sign_in': 'Sign In',
      'logout': 'Logout',

      // Forms
      'first_name': 'First Name',
      'last_name': 'Last Name',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'register': 'Register',
      'login': 'Login',

      // Errors
      'invalid_email': 'Invalid email',
      'passwords_do_not_match': 'Passwords do not match',
      'email_already_exists': 'User with this email already exists',
      'validation_error': 'Validation error',

      // Marketplace
      'products': 'Products',
      'categories': 'Categories',
      'cart': 'Cart',
      'profile': 'Profile',

      // Welcome screen
      'welcome_title': 'Welcome to SHUM',
      'welcome_subtitle': 'Your new marketplace',
      'get_started': 'Get Started',
    },
  };
}

/// Делегат для AppLocalizations
class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return AppLocalizations.supportedLocales.any((supportedLocale) =>
        supportedLocale.languageCode == locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
