import 'package:flutter/material.dart';
import '../widgets/password_field.dart';
import '../widgets/custom_button.dart';

class PasswordRecovery extends StatefulWidget {
  const PasswordRecovery({super.key});

  @override
  PasswordRecoveryState createState() => PasswordRecoveryState();
}

class PasswordRecoveryState extends State<PasswordRecovery> {
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
            const SizedBox(height: 30),
            PasswordField(
              controller: _newPasswordController,
              showCounter: true,
              labelText: 'Введіть пароль',
              validator: (String? value) {},
            ),
            const SizedBox(height: 10),
            PasswordField(
              controller: _confirmPasswordController,
              labelText: 'Введіть пароль',
              validator: (String? value) {},
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
            CustomButton(
              text: 'Зберегти пароль',
              onPressed: _isButtonEnabled
                  ? () {
                      if (_newPasswordController.text ==
                          _confirmPasswordController.text) {
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
