import 'package:flutter/material.dart';

import '../../../services/auth_service.dart';
import '../../../services/auth_storage.dart';
import '../../../utils/validators.dart';

import '../../widgets/auth_widgets/auth_field.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/form_header.dart';

import '../../widgets/loading_dialog.dart';
import '../reset_password/forgot_password.page.dart';
import '../registration/registration_page.dart';

import '../../themes/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_checkFormFilled);
    _passwordController.addListener(_checkFormFilled);
  }

  @override
  void dispose() {
    _emailController.removeListener(_checkFormFilled);
    _passwordController.removeListener(_checkFormFilled);
    super.dispose();
  }

  void _checkFormFilled() {
    final isFormFilled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    setState(() {
      _isButtonDisabled = !isFormFilled;
    });
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text;
    final password = _passwordController.text;
    LoadingDialog.show(context);

    try {
      final response = await AuthService.loginUser(email, password);
      LoadingDialog.hide(context);

      if (response.containsKey('token')) {
        final token = response['token'];
        await AuthStorage.saveToken(token);

        if (mounted) {
          Navigator.pushReplacementNamed(context, '/greeting');
        }
      } else {
        final errorMessage =
            response['message'] ?? 'Невірна електронна пошта або пароль';
        if (mounted) {
          _showErrorDialog(context, errorMessage);
        }
      }
    } catch (e) {
      LoadingDialog.hide(context);
      if (mounted) {
        _showErrorDialog(
            context, 'Щось пішло не так. Будь ласка, спробуйте пізніше.');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Помилка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileLayout(textTheme);
          } else {
            return _buildDesktopLayout(textTheme);
          }
        },
      ),
    );
  }

  Widget _buildMobileLayout(TextTheme textTheme) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Назад'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 111),
                const FormHeader(
                  text: 'SHUM',
                ),
                const SizedBox(height: 40),
                Column(
                  children: [
                    Text(
                      'Вхід',
                      textAlign: TextAlign.center,
                      style: textTheme.displayLarge,
                    ),
                    Text(
                      'Вхід',
                      textAlign: TextAlign.center,
                      style: textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
                const SizedBox(height: 40),
                AuthField(
                  labelText: 'Ваша пошта',
                  hintText: "Введіть пошту",
                  controller: _emailController,
                  validator: validateEmail,
                  showSuffixIcon: (text) {
                    return validateEmail(text) == null;
                  },
                ),
                const SizedBox(height: 16),
                AuthField(
                  labelText: 'Пароль',
                  hintText: "Введіть пароль",
                  controller: _passwordController,
                  validator: validatePassword,
                  isObscureText: true,
                ),
                SizedBox(
                  width: 354,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Не пам\'ятаю пароль',
                        style: textTheme.bodySmall?.copyWith(
                            color: AppTheme.linkTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                AuthButton(
                  text: 'Увійти в акаунт',
                  onPressed: _handleLogin,
                  isButtonDisabled: _isButtonDisabled,
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegistrationPage(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: textTheme.bodyMedium?.copyWith(),
                      children: const [
                        TextSpan(
                            text: 'Ще не маєте акаунт? ',
                            style: TextStyle(
                              fontSize: 15,
                            )),
                        TextSpan(
                          text: ' Зареєструватись',
                          style: TextStyle(
                            fontSize: 15,
                            color: AppTheme.linkTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(TextTheme textTheme) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 33.0, horizontal: 0),
            child: Center(
              child: Container(
                width: 651,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: const Color(0xFFF7F5F2),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Image.asset(
                        'assets/images/logo_desktop.png',
                        width: 48,
                        height: 69,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        'assets/images/logIn_icons/Log_in_img.png',
                        width: 651,
                        height: 630,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding:
                const EdgeInsets.only(right: 50.0, top: 33.0, bottom: 33.0),
            child: _buildMobileLayout(textTheme),
          ),
        ),
      ],
    );
  }
}
