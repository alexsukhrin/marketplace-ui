import 'package:flutter/material.dart';

import '../../../services/password_reset_service.dart';
import '../../../utils/validators.dart';

import '../../widgets/auth_widgets/auth_field.dart';
import '../../widgets/auth_widgets/auth_button.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  ResetPasswordPageState createState() => ResetPasswordPageState();
}

class ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isButtonEnabled = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();

    _newPasswordController.addListener(_checkFields);
    _confirmPasswordController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _isButtonEnabled = _newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;

      if (_newPasswordController.text == _confirmPasswordController.text) {
        _errorMessage = null;
      }
    });
  }

  Future<void> _resetPassword() async {
    final newPassword = _newPasswordController.text;

    try {
      await PasswordResetService.resetPassword(newPassword);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пароль успішно змінено!')),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _errorMessage = 'Помилка зміни пароля. Спробуйте ще раз.';
      });
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 72),
            Center(
              child: Image.asset(
                'assets/images/logIn_icons/key_icon.png',
                width: 50,
                height: 50,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Відновлення паролю',
              style: textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              'Введіть новий пароль',
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            AuthField(
              hintText: 'Пароль',
              controller: _newPasswordController,
              showCounter: true,
              labelText: 'Введіть пароль',
              validator: validatePassword,
              isObscureText: true,
              showSuffixIcon: (text) {
                return validatePassword(text) == null;
              },
            ),
            AuthField(
              hintText: 'Повторіть пароль',
              controller: _confirmPasswordController,
              labelText: 'Поворіть пароль',
              validator: validatePassword,
              isObscureText: true,
              showSuffixIcon: (text) {
                return validatePassword(text) == null;
              },
            ),
            const SizedBox(height: 10),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            const SizedBox(height: 40),
            AuthButton(
              text: 'Зберегти пароль',
              onPressed: _isButtonEnabled
                  ? () {
                      if (_newPasswordController.text ==
                          _confirmPasswordController.text) {
                        _resetPassword();
                      } else {
                        setState(() {
                          _errorMessage = 'Паролі не співпадають!';
                        });
                      }
                    }
                  : null,
              disabledColor: const Color(0xFFFFCC85),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}