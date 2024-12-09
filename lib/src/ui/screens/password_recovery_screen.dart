import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/screens/code_validate.dart';
import '../widgets/form_header.dart';
import '../widgets/login_field.dart';
import '../widgets/custom_button.dart';
import '../../utils/validators.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  State<PasswordRecoveryScreen> createState() => _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  void _onSendCode() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CodeValidate(),
        ),
      );
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
                  text: 'Marketplace',
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
              LoginField(
                labelText: "Введіть пошту",
                controller: _emailController,
                validator: validateEmail,
              ),
              const SizedBox(height: 40),
              CustomButton(
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
