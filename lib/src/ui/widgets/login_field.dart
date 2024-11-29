import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Логін',
        border: OutlineInputBorder(),
      ),
    );
  }
}
