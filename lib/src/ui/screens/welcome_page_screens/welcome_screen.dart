import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';
import 'package:flutter_application_1/src/ui/widgets/shared_widgets/custom_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/shared_widgets/language_selector.dart';
import '../../../localization/app_localizations.dart';
import '../../widgets/responsive/responsive_design.dart';
import '../../widgets/welcome_page_widgets/left_section.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: TResponsiveWidget(
        desktop: Padding(
          padding: EdgeInsets.symmetric(vertical: 33.0, horizontal: 61.0),
          child: Desktop(),
        ),
        tablet: Tablet(),
        mobile: Mobile(),
      ),
    );
  }
}

class Desktop extends ConsumerWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: Row(
        children: [
          const LeftSection(
              imagePath: 'assets/images/welcome_page/welcome_screen.svg'),

          // Right Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Language Selector
                  const LanguageSelector(),

                  // Main Content
                  Column(
                    children: [
                      const WelcomeText(),
                      const SizedBox(height: 36),
                      CustomButton(
                        text: l10n.signUp,
                        onPressed: () {
                          Navigator.pushNamed(context, '/registration');
                        },
                        isButtonDisabled: false,
                        buttonType: ButtonType.filled, // Filled button
                      ),
                      const SizedBox(height: 8),
                      CustomButton(
                        text: l10n.signIn,
                        onPressed: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        isButtonDisabled: false,
                        buttonType: ButtonType.outlined, // Outlined button
                      ),
                    ],
                  ),

                  // Skip Text

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/main');
                    },
                    child: Text(
                      l10n.skipStep,
                      style: const TextStyle(
                        color: Color(0xFF8E8E8E),
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Mobile extends ConsumerWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColorWhite,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Skip Button
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/main');
              },
              child: const Text(
                'Пропустити',
                style: TextStyle(
                  color: AppTheme.lightBodyColor,
                  fontSize: 15,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            // Logo
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 28,
            ),
            const SizedBox(height: 7),

            // SHUM title
            const Text(
              "SHUM",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 36),

            // Full-Screen SVG
            Expanded(
              child: SvgPicture.asset(
                'assets/images/welcome_page/welcome_screen.svg',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 36),

            // Welcome Text
            const WelcomeText(),

            const SizedBox(height: 35),
            Center(
              child: Column(
                children: [
                  CustomButton(
                    text: "Зареєструватись",
                    onPressed: () {
                      Navigator.pushNamed(context, '/registration');
                    },
                    isButtonDisabled: false,
                    buttonType: ButtonType.filled,
                  ),
                  const SizedBox(height: 8),
                  CustomButton(
                    text: "Увійти",
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    isButtonDisabled: false,
                    buttonType: ButtonType.outlined,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}

class WelcomeText extends ConsumerWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          l10n.welcomeTitle,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.welcomeSubtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppTheme.lightBodyColor,
          ),
        ),
      ],
    );
  }
}
