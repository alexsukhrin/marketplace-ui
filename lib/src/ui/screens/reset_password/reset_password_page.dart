import 'package:flutter/material.dart';

import '../../../services/password_reset_service.dart';
import '../../../utils/validators.dart';

import '../../shared_pages/success_page.dart.dart';
import '../../widgets/auth_widgets/auth_field.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/loading_dialog.dart';

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
  String? _newPasswordError;
  String? _confirmPasswordError;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_checkFields);
    _confirmPasswordController.addListener(_checkFields);
  }

  void _checkFields() {
    setState(() {
      _newPasswordError = validatePassword(_newPasswordController.text);
      _confirmPasswordError = validatePassword(_confirmPasswordController.text);

      if (_newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _newPasswordController.text != _confirmPasswordController.text) {
        _confirmPasswordError = 'Паролі не співпадають!';
      }

      _isButtonEnabled = _newPasswordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty &&
          _newPasswordError == null &&
          _confirmPasswordError == null &&
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _resetPassword() async {
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    setState(() {
      _newPasswordError = validatePassword(newPassword);
      _confirmPasswordError = validatePassword(confirmPassword);
    });

    if (_newPasswordError != null || _confirmPasswordError != null) {
      return;
    }

    if (newPassword != confirmPassword) {
      setState(() {
        _confirmPasswordError = 'Паролі не співпадають!';
      });
      return;
    }

    LoadingDialog.show(context);

    try {
      await PasswordResetService.resetPassword(newPassword);
      LoadingDialog.hide(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пароль успішно змінено!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SuccessPage(
            title: 'Пароль змінено!',
            message:
                'Ваш пароль успішно змінено. Ви можете увійти, використовуючи новий пароль.',
          ),
        ),
      );
    } catch (e) {
      LoadingDialog.hide(context);
      setState(() {
        _confirmPasswordError = 'Помилка зміни пароля. Спробуйте ще раз.';
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 600;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Container(
                width: isDesktop ? 624 : double.infinity,
                height: isDesktop ? 549 : double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: isDesktop
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            blurRadius: 200,
                            spreadRadius: 20,
                            offset: const Offset(0, -10),
                          ),
                        ],
                      )
                    : null,
                child: Column(
                  children: [
                    SizedBox(height: isDesktop ? 0 : 72),
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
                    SizedBox(height: isDesktop ? 44 : 40),
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
                      errorText: _newPasswordError,
                    ),
                    AuthField(
                      hintText: 'Повторіть пароль',
                      controller: _confirmPasswordController,
                      labelText: 'Поворіть пароль',
                      validator: validatePassword,
                      isObscureText: true,
                      showCounter: true,
                      showSuffixIcon: (text) {
                        return validatePassword(text) == null;
                      },
                      errorText: _confirmPasswordError,
                    ),
                    SizedBox(height: isDesktop ? 44 : 40),
                    AuthButton(
                      text: 'Відновити пароль',
                      onPressed: _isButtonEnabled &&
                              _newPasswordController.text ==
                                  _confirmPasswordController.text
                          ? () {
                              _resetPassword();
                            }
                          : null,
                      disabledColor: const Color(0xFFFFCC85),
                    ),
                    SizedBox(height: isDesktop ? 0 : 50),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
