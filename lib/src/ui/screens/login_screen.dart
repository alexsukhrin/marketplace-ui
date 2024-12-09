import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../widgets/login_field.dart';
import '../widgets/password_field.dart';
import '../widgets/custom_button.dart';
import '../widgets/form_header.dart';

import 'password_recovery_screen.dart';
import 'registration_screen.dart';

import '../themes/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final logger = Logger();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 111),
            const FormHeader(
              text: 'Marketplace',
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                Text(
                  'Вхід',
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
            const SizedBox(height: 40),
            const LoginField(labelText: "Логін"),
            const SizedBox(height: 16),
            const PasswordField(
              showCounter: false,
              labelText: "Введіть пароль",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PasswordRecoveryScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Не пам\'ятаєте пароль?',
                    style: textTheme.bodySmall?.copyWith(
                        color: AppTheme.linkTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomButton(
              text: 'Увійти в акаунт',
              onPressed: () {
                logger.i('Вхід');
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationScreen(),
                  ),
                );
              },
              child: RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  children: const [
                    TextSpan(
                        text: 'Не маєте акаунт? ',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                        )),
                    TextSpan(
                      text: 'Зареєструватись',
                      style: TextStyle(
                        color: AppTheme.linkTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
