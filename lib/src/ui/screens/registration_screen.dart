import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';
import '../widgets/password_field.dart';
import '../widgets/login_field.dart';
import '../widgets/form_header.dart';
import '../../utils/validators.dart';

import '../themes/app_theme.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const FormHeader(
              text: 'Marketplace',
            ),
            const SizedBox(height: 30),
            Column(
              children: [
                Text(
                  'Реєстрація',
                  textAlign: TextAlign.center,
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Отримайте більше можливостей\nстворивши акаунт',
                  textAlign: TextAlign.center,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoginField(
                    labelText: 'Ім’я',
                    validator: validateName,
                  ),
                  const SizedBox(height: 20),
                  const LoginField(
                    labelText: 'Прізвище',
                    validator: validateName,
                  ),
                  const SizedBox(height: 20),
                  const LoginField(labelText: 'Електронна пошта'),
                  const SizedBox(height: 20),
                  const PasswordField(
                    showCounter: true,
                    labelText: "Введіть пароль",
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Зареєструватися',
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Реєстрація успішна!')),
                        );
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Вже маєте акаунт? ',
                          ),
                          TextSpan(
                            text: 'Увійти',
                            style: TextStyle(
                              color: AppTheme.linkTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
