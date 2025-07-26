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
  String get skipStep =>
      _localizedValues[locale.languageCode]!['skip_step']!;
  String get downloadApp =>
      _localizedValues[locale.languageCode]!['download_app']!;
  
  // === РЕЄСТРАЦІЯ ===
  String get yourName => _localizedValues[locale.languageCode]!['your_name']!;
  String get yourSurname => _localizedValues[locale.languageCode]!['your_surname']!;
  String get yourEmail => _localizedValues[locale.languageCode]!['your_email']!;
  String get enterName => _localizedValues[locale.languageCode]!['enter_name']!;
  String get enterSurname => _localizedValues[locale.languageCode]!['enter_surname']!;
  String get enterEmail => _localizedValues[locale.languageCode]!['enter_email']!;
  String get enterPassword => _localizedValues[locale.languageCode]!['enter_password']!;
  String get enterPasswordAgain => _localizedValues[locale.languageCode]!['enter_password_again']!;
  String get repeatPassword => _localizedValues[locale.languageCode]!['repeat_password']!;
  String get alreadyHaveAccount => _localizedValues[locale.languageCode]!['already_have_account']!;

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
      'welcome_title': 'Привіт!',
      'welcome_subtitle': 'Отримай безпечний досвід покупок\n разом з нами',
      'get_started': 'Почати',
      'skip_step': 'Пропустити цей крок',
      'download_app': 'Завантажити застосунок',
      
      // Реєстрація
      'your_name': 'Ваше ім\'я',
      'your_surname': 'Ваше прізвище', 
      'your_email': 'Ваша пошта',
      'enter_name': 'Введіть ім\'я',
      'enter_surname': 'Введіть прізвище',
      'enter_email': 'Введіть пошту',
      'enter_password': 'Введіть пароль',
      'enter_password_again': 'Введіть пароль повторно',
      'repeat_password': 'Повторіть пароль',
      'already_have_account': 'Вже маєте акаунт?',
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
      'sign_in': 'Log In',
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
      'welcome_title': 'Welcome!',
      'welcome_subtitle': 'Get a safe shopping experience \n with us',
      'get_started': 'Get Started',
      'skip_step': 'Skip for now',
      'download_app': 'Download App',
      
      // Registration
      'your_name': 'Your Name',
      'your_surname': 'Your Surname',
      'your_email': 'Your Email',
      'enter_name': 'Enter name',
      'enter_surname': 'Enter surname',
      'enter_email': 'Enter email',
      'enter_password': 'Enter password',
      'enter_password_again': 'Enter password again',
      'repeat_password': 'Repeat password',
      'already_have_account': 'Already have an account?',
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
