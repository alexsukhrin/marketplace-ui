import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/src/ui/screens/login/login_page.dart';
import 'package:flutter_application_1/src/ui/widgets/shared_widgets/language_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../localization/app_localizations.dart';

import '../../../exceptions/email_already_registered_exception.dart';
import '../../../services/auth_service.dart';

import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/auth_widgets/auth_field.dart';
import '../../../utils/validators.dart';
import '../../widgets/loading_dialog.dart';

class RegistrationPage extends ConsumerStatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends ConsumerState<RegistrationPage> {
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
          Navigator.pushReplacementNamed(context, '/greeting');
        }
      } catch (e, stackTrace) {
        LoadingDialog.hide(context);
        print('Caught error: $e');
        print('Stack trace: $stackTrace');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Помилка'),
            content: SingleChildScrollView(
              child: Text('$e\n\n$stackTrace'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );

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
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 1440,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return _buildMobileLayout(Theme.of(context).textTheme);
              } else {
                return _buildDesktopLayout(Theme.of(context).textTheme);
              }
            },
          ),
        ),
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
          scrolledUnderElevation: 0,
          actions: const [
            LanguageSelector(),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 76),
                Text(
                  l10n.signUp,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 32),
                ),
                const SizedBox(height: 8),
                Text(
                  'Отримайте більше можливостей\nстворивши акаунт',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 48),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                        labelText: l10n.yourName,
                        labelText: 'Ваше ім’я',
                        validator: validateName,
                        controller: _firstNameController,
                        hintText: l10n.enterName,
                        showSuffixIcon: (text) {
                          return validateName(text) == null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AuthField(
                        labelText: l10n.yourSurname,
                        validator: validateName,
                        controller: _lastNameController,
                        hintText: l10n.enterSurname,
                        showSuffixIcon: (text) {
                          return validateName(text) == null;
                        },
                      ),
                      const SizedBox(height: 12),
                      AuthField(
                        labelText: l10n.yourEmail,
                        controller: _emailController,
                        hintText: l10n.enterEmail,
                        validator: validateEmail,
                        showSuffixIcon: (text) {
                          return validateEmail(text) == null;
                        },
                        errorText: _emailError,
                      ),
                      const SizedBox(height: 12),
                      AuthField(
                        labelText: l10n.password,
                        controller: _passwordController,
                        hintText: l10n.enterPassword,
                        validator: validatePassword,
                        showCounter: true,
                        isObscureText: true,
                      ),
                      AuthField(
                        labelText: l10n.repeatPassword,
                        controller: _confirmPasswordController,
                        hintText: l10n.enterPasswordAgain,
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return l10n.passwordsDoNotMatch;
                          }
                          return validatePassword(value);
                        },
                        showCounter: true,
                        isObscureText: true,
                      ),
                      const SizedBox(height: 40),
                      AuthButton(
                        text: l10n.register,
                        isButtonDisabled: _isButtonDisabled,
                        onPressed: () {
                          _firstNameController.text =
                              _firstNameController.text.replaceAll(' ', '');
                          _lastNameController.text =
                              _lastNameController.text.replaceAll(' ', '');
                          registerUser(context);
                        },
                      ),
                      TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: const [
                              TextSpan(
                                text: l10n.alreadyHaveAccount + ' ',
                              ),
                              TextSpan(
                                text: l10n.signIn,
                                style: TextStyle(
                                  color: TColors.orange,
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
