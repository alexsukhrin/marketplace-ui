import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

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
        Text(
          'Вітаємо знову у Shum! ',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: TColors.greyDark),
        ),
      ],
    );
  }
}
