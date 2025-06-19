import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/src/ui/screens/reset_password/forgot_password.page.dart';

class ForgotPasswordButton extends StatelessWidget {
  final String? email;
  const ForgotPasswordButton({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 409,
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgotPasswordPage(email: email),
              ),
            );
          },
          child: Text('Не пам\'ятаю пароль',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: TColors.orange)),
        ),
      ),
    );
  }
}
