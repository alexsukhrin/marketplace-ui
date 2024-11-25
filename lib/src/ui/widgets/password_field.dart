import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        labelText: 'Пароль',
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon:
              Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
      ),
    );
  }
}
