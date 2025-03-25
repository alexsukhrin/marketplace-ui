import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // const SizedBox(height: 111),
        // const FormHeader(
        //   text: 'SHUM',
        // ),
        Text(
          'Вхід',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
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
