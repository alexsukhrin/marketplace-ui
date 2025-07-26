import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_application_1/src/services/auth_storage.dart';
import 'package:flutter_application_1/src/ui/screens/notFoundScreen/page_not_found_screen.dart';
import 'package:flutter_application_1/src/ui/screens/registration/registration_page.dart';
import 'package:flutter_application_1/src/ui/screens/main/main_screen.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/choose_role_screen.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/select_category_screen.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/welcome_screen.dart';
import 'package:flutter_application_1/src/ui/themes/providers/theme_provider.dart';
import 'package:flutter_application_1/src/ui/themes/t_app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/localization/app_localizations.dart';
import 'src/providers/language_provider.dart';
import 'src/ui/screens/categories/all_categories_page.dart';
import 'src/ui/screens/login/login_page.dart';
import 'src/ui/shared_pages/success_page.dart.dart';
import 'src/ui/screens/welcome_page_screens/greeting_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthStorage.init();
  runApp(
    const ProviderScope(
      child: Marcketplace(),
    ),
  );
}

class Marcketplace extends ConsumerStatefulWidget {
  const Marcketplace({super.key});

  @override
  ConsumerState<Marcketplace> createState() => _MarcketplaceState();
}

class _MarcketplaceState extends ConsumerState<Marcketplace> {
  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SHUM',
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode:
          themeMode == AppThemeMode.light ? ThemeMode.light : ThemeMode.dark,

      // Додаємо підтримку локалізації
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/succesRegistration': (context) => const SuccessPage(),
        '/greeting': (context) => const GreetingScreen(),
        '/chooseRole': (context) => const ChooseRoleScreen(),
        '/selectCategory': (context) => const SelectCategoryScreen(),
        '/main': (context) => const MainScreen(),
        '/categories': (context) => const AllCategoriesPage(),
        '/notFoundScreen': (context) => const PageNotFoundScreen()
      },
      builder: (context, child) {
        return Scaffold(
          body: child!,
        );
      },
    );
  }
}
