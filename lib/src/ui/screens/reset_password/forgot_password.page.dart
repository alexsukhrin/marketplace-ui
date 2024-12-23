import 'package:flutter/material.dart';

import '../../../exceptions/user_not_found_exception.dart';
import '../../../services/password_reset_service.dart';
import 'code_validate_page.dart';
import '../../../utils/validators.dart';

import '../../widgets/auth_widgets/form_header.dart';
import '../../widgets/auth_widgets/auth_field.dart';
import '../../widgets/auth_widgets/auth_button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isButtonDisabled = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonDisabled = _emailController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _emailController.removeListener(_updateButtonState);
    _emailController.dispose();
    super.dispose();
  }

  bool _containsVerificationCode(String message) {
    return message.length == 6 && RegExp(r'^[0-9]+$').hasMatch(message);
  }

  void _onSendCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );

      try {
        final response = await PasswordResetService.sendRecoveryEmail(email);
        Navigator.pop(context);

        String successMessage =
            response['message'] ?? 'Лист для відновлення паролю надіслано';
        if (_containsVerificationCode(successMessage)) {
          successMessage = 'Лист для відновлення паролю надіслано';
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CodeValidatePage(email: email),
          ),
        );
      } catch (e) {
        Navigator.pop(context);
        if (e is UserNotFoundException) {
          _showSnackBarMessage(e.message);
        } else {
          _showSnackBarMessage('Сталася помилка. Спробуйте ще раз.');
        }
      }
    } else {
      _showSnackBarMessage('Будь ласка, виправте помилки у формі');
    }
  }

  void _showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Center(
                child: FormHeader(
                  text: 'SHUM',
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Відновлення паролю',
                textAlign: TextAlign.center,
                style: textTheme.displayLarge?.copyWith(),
              ),
              const SizedBox(height: 8),
              Text(
                'Введіть електронну пошту за якою було зареєстровано акаунт',
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(),
              ),
              const SizedBox(height: 68),
              AuthField(
                labelText: "Введіть пошту",
                controller: _emailController,
                validator: validateEmail,
                hintText: "Введіть пошту",
                showSuffixIcon: (text) {
                  return validateEmail(text) == null;
                },
              ),
              const SizedBox(height: 40),
              AuthButton(
                text: 'Надіслати код',
                onPressed: _onSendCode,
                isButtonDisabled: _isButtonDisabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
