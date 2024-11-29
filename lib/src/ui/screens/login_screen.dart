import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../widgets/login_field.dart';
import '../widgets/password_field.dart';
import '../widgets/custom_button.dart';

import 'registration_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logger = Logger();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LoginField(),
            const SizedBox(height: 16),
            const PasswordField(),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Вхід',
              onPressed: () {
                logger.i('Вхід');
              },
            ),
            const SizedBox(height: 16),
            CustomButton(
              text: 'Перейти до реєстрації',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
