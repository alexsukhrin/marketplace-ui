import 'package:flutter/material.dart';

import '../../../exceptions/email_already_registered_exception.dart';
import '../../../services/auth_service.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_field.dart';
import '../../widgets/auth_widgets/form_header.dart';
import '../../../utils/validators.dart';

import '../../themes/app_theme.dart';
import '../../widgets/loading_dialog.dart';
import '../welcome_page_screens/greeting_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  String? _emailError;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isButtonDisabled = true;

  Map<String, String> getFormData() {
    return {
      "first_name": _firstNameController.text,
      "last_name": _lastNameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
    };
  }

  @override
  void initState() {
    super.initState();

    _firstNameController.addListener(_checkFormFilled);
    _lastNameController.addListener(_checkFormFilled);
    _emailController.addListener(_checkFormFilled);
    _passwordController.addListener(_checkFormFilled);
    _confirmPasswordController.addListener(_checkFormFilled);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkFormFilled() {
    final isFormFilled = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;

    setState(() {
      _isButtonDisabled = !isFormFilled;
    });
  }

  Future<void> registerUser(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final formData = getFormData();
      LoadingDialog.show(context);
      try {
        await AuthService.registerUser(formData);

        LoadingDialog.hide(context);

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const GreetingScreen(),
            ),
          );
        }
      } catch (e) {
        LoadingDialog.hide(context);
        print('Caught error: $e');

        if (e is EmailAlreadyRegisteredException) {
          setState(() {
            _emailError = 'Ця пошта вже використовується';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Сталася помилка. Спробуйте ще раз.')),
          );
        }
      }
    }
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
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
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
                    children: [
                      AuthField(
                        labelText: 'Ваше ім’я',
                        validator: validateName,
                        controller: _firstNameController,
                        hintText: "Введіть ім'я",
                        showSuffixIcon: (text) {
                          return validateName(text) == null;
                        },
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        labelText: 'Ваше прізвище',
                        validator: validateName,
                        controller: _lastNameController,
                        hintText: "Введіть прізвище",
                        showSuffixIcon: (text) {
                          return validateName(text) == null;
                        },
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        labelText: 'Ваша пошта',
                        controller: _emailController,
                        hintText: 'Введіть пошту',
                        validator: validateEmail,
                        showSuffixIcon: (text) {
                          return validateEmail(text) == null;
                        },
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 15),
                      AuthField(
                        labelText: 'Пароль',
                        controller: _passwordController,
                        hintText: 'Введіть пароль',
                        validator: validatePassword,
                        showCounter: true,
                        isObscureText: true,
                      ),
                      AuthField(
                        labelText: 'Повторіть пароль',
                        controller: _confirmPasswordController,
                        hintText: 'Введіть пароль повторно',
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return 'Паролі не співпадають';
                          }
                          return validatePassword(value);
                        },
                        showCounter: true,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 16),
                      AuthButton(
                        text: 'Зареєструватися',
                        isButtonDisabled: _isButtonDisabled,
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
                        'assets/images/signUp_images/Sign_up_img.png',
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
