import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_field.dart';
import '../../widgets/auth_widgets/form_header.dart';
import '../../../utils/validators.dart';

import '../../themes/app_theme.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, String> getFormData() {
    return {
      "first-name": _firstNameController.text,
      "last-name": _lastNameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    };
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = getFormData();
      await AuthService.registerUser(formData);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Реєстрація успішна!')),
        );

        Navigator.pushReplacementNamed(context, '/succesRegistration');
      }
    }
  }

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
              text: 'SHUM',
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
                  AuthField(
                    labelText: 'Ім’я',
                    validator: validateName,
                    controller: _firstNameController,
                    hintText: "Введіть ім'я",
                    showSuffixIcon: (text) {
                      return validateName(text) == null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    labelText: 'Прізвище',
                    validator: validateName,
                    controller: _lastNameController,
                    hintText: "Введіть прізвище",
                    showSuffixIcon: (text) {
                      return validateName(text) == null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    labelText: 'Електронна пошта',
                    controller: _emailController,
                    hintText: 'Введіть пошту',
                    validator: validateEmail,
                    showSuffixIcon: (text) {
                      return validateEmail(text) == null;
                    },
                  ),
                  const SizedBox(height: 20),
                  AuthField(
                    labelText: 'Пароль',
                    controller: _passwordController,
                    hintText: 'Введіть пароль',
                    validator: validatePassword,
                    showCounter: true,
                    isObscureText: true,
                  ),
                  const SizedBox(height: 16),
                  AuthButton(
                    text: 'Зареєструватися',
                    onPressed: () {
                      registerUser(context);
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
