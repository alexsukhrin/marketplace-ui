import 'package:flutter/material.dart';
import './src/ui/screens/login_screen.dart';
import './src/ui/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const LoginScreen(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Marketplace'),
            actions: [
              IconButton(
                icon: Icon(
                  _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                ),
                onPressed: _toggleTheme,
              ),
            ],
          ),
          body: child!,
        );
      },
    );
  }
}
