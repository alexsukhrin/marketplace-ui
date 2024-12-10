import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

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

        Navigator.pushReplacementNamed(context, '/greeting');
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
                  LoginField(
                    labelText: 'Ім’я',
                    validator: validateName,
                    controller: _firstNameController,
                  ),
                  const SizedBox(height: 20),
                  LoginField(
                    labelText: 'Прізвище',
                    validator: validateName,
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 20),
                  LoginField(
                    labelText: 'Електронна пошта',
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  PasswordField(
                    showCounter: true,
                    labelText: "Введіть пароль",
                    controller: _passwordController,
                    validator: (String? value) {},
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
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
