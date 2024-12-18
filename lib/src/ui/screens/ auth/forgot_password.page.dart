import 'package:flutter/material.dart';

import 'code_validate_page.dart';
import '../../../utils/validators.dart';
import '../../../services/auth_service.dart';

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

  void _onSendCode() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text;

      try {
        await AuthService.sendRecoveryEmail(email);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Лист для відновлення паролю надіслано')),
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CodeValidatePage(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Будь ласка, виправте помилки у формі')),
      );
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
              ),
              const SizedBox(height: 40),
              AuthButton(
                text: 'Надіслати код',
                onPressed: _onSendCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
