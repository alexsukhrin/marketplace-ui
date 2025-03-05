import 'package:flutter/material.dart';

import '../../../exceptions/user_not_found_exception.dart';
import '../../../services/password_reset_service.dart';
import '../../widgets/loading_dialog.dart';
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
  String? _emailError;
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
    setState(() {
      _emailError = null;
    });
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;

      LoadingDialog.show(context);

      try {
        final response = await PasswordResetService.sendRecoveryEmail(email);
        LoadingDialog.hide(context);
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
        LoadingDialog.hide(context);
        Navigator.pop(context);
        if (e is UserNotFoundException) {
          setState(() {
            _emailError = 'Будь ласка, введіть дійсну адресу електронної пошти';
          });
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isDesktop = constraints.maxWidth > 600;
          return Center(
            child: Container(
              width: isDesktop ? 624 : double.infinity,
              height: isDesktop ? 460 : double.infinity,
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (isDesktop)
                    Container(
                      width: 624,
                      height: 460,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            blurRadius: 200,
                            spreadRadius: 20,
                            offset: Offset(0, -10),
                          ),
                        ],
                      ),
                    ),
                  Container(
                    width: isDesktop ? 624 : double.infinity,
                    height: isDesktop ? 460 : double.infinity,
                    padding: const EdgeInsets.all(16.0),
                    decoration: isDesktop
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          )
                        : null,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          if (!isDesktop)
                            const Center(
                              child: FormHeader(
                                text: 'SHUM',
                              ),
                            ),
                          SizedBox(height: isDesktop ? 0 : 40),
                          Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: isDesktop ? 378 : double.infinity,
                              ),
                              child: Column(
                                children: [
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: isDesktop ? 44 : 40),
                          AuthField(
                            labelText: "Ваша пошта",
                            controller: _emailController,
                            validator: validateEmail,
                            hintText: "Введіть пошту",
                            showSuffixIcon: isDesktop
                                ? (_) => false
                                : (text) {
                                    return validateEmail(text) == null;
                                  },
                            errorText: _emailError,
                          ),
                          SizedBox(height: isDesktop ? 44 : 40),
                          AuthButton(
                            text: 'Надіслати код',
                            onPressed: _onSendCode,
                            isButtonDisabled: _isButtonDisabled,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
