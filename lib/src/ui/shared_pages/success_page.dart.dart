import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/auth_widgets/auth_button.dart';

import '../themes/app_theme.dart';

class SuccessPage extends StatelessWidget {
  final String? title;
  final String? message;

  const SuccessPage({
    super.key,
    this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check,
              color: AppTheme.successColor,
              size: 150,
            ),
            Text(
              title!,
              style: textTheme.displayLarge
                  ?.copyWith(color: AppTheme.successColor),
            ),
            Text(
              textAlign: TextAlign.center,
              message!,
              style: textTheme.bodyMedium?.copyWith(),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: AuthButton(
            text: 'Увійти',
            isButtonDisabled: false,
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
        ),
      ),
    );
  }
}
