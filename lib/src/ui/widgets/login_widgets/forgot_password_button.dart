import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/screens/reset_password/forgot_password.page.dart';
import '../../themes/app_theme.dart';

class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: 354,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ForgotPasswordPage(),
              ),
            );
          },
          child: Text(
            'Не пам\'ятаю пароль',
            style: textTheme.bodySmall?.copyWith(
              color: AppTheme.linkTextColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
