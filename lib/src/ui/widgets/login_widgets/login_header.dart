import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(height: 111),
        // const FormHeader(
        //   text: 'SHUM',
        // ),
        Text(
          'Вхід',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32),
        ),
        const SizedBox(height: 8),
        const Text(
          'Вітаємо знову у Shum! ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Color(0xFF757575),
          ),
        ),
      ],
    );
  }
}
