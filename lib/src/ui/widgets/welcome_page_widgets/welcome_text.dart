import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Привіт!",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Отримай безпечний досвід покупок\n разом з нами",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.lightBodyColor,
          ),
        ),
      ],
    );
  }
}
