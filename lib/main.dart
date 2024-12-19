import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/screens/%20auth/registration_page.dart';
import 'package:flutter_application_1/src/ui/screens/main_screen.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/choose_role_screen.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/select_category_screen.dart';
import 'package:flutter_application_1/src/ui/screens/welcome_page_screens/welcome_screen.dart';
import 'src/ui/screens/ auth/login_page.dart';
import './src/ui/themes/app_theme.dart';
import 'src/ui/screens/ auth/registration_success_page.dart';
import 'src/ui/screens/welcome_page_screens/greeting_screen.dart';

void main() {
  runApp(const Marcketplace());
}

class Marcketplace extends StatefulWidget {
  const Marcketplace({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<Marcketplace> {
  // bool _isDarkMode = false;

  // void _toggleTheme() {
  //   setState(() {
  //     _isDarkMode = !_isDarkMode;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marketplace',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      // themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/registration': (context) => const RegistrationPage(),
        '/succesRegistration': (context) => const RegistrationSuccessPage(),
        '/greeting': (context) => const GreetingScreen(),
        '/chooseRole': (context) => const ChooseRoleScreen(),
        '/selectCategory': (context) => const SelectCategoryScreen(),
        '/main': (context) => const MainScreen(),
      },
      builder: (context, child) {
        return Scaffold(
          // appBar: AppBar(
          //   title: const Text('Marketplace'),
          //   actions: [
          //     IconButton(
          //       icon: Icon(
          //         _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
          //       ),
          //       onPressed: _toggleTheme,
          //     ),
          //   ],
          // ),
          body: child!,
        );
      },
    );
  }
}
