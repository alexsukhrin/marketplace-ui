import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../localization/app_localizations.dart';

class LoginHeader extends ConsumerWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Column(
      children: [
        // const SizedBox(height: 111),
        // const FormHeader(
        //   text: 'SHUM',
        // ),
        Text(
          l10n.signIn,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 32),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.welcomeBack,
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
