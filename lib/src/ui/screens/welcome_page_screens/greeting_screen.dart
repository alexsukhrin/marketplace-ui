import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/auth_widgets/auth_button.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColorWhite,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 30,
            ),
            // Skip Button
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/chooseRole');
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
          children: [
            const SizedBox(height: 10),
            // Greeting Text
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.90,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Дякуємо, що обрали наш застосунок!",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.lightBodyColor,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Давай спершу познайомимось?",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppTheme.lightBodyColor,
                    ),
                  ),
                ],
              ),
            ),

            // Full-Screen SVG
            Expanded(
              child: SvgPicture.asset(
                'assets/images/welcome_page/greeting_screen.svg',
                fit: BoxFit.contain,
              ),
            ),

            // Progress Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 6,
                  width: 30,
                  decoration: BoxDecoration(
                    color: AppTheme.progressIndicatorActive,
                    borderRadius:
                        BorderRadius.circular(3), // Add rounded corners
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: AppTheme.progressIndicatorInactive,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: AppTheme.progressIndicatorInactive,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Button
            AuthButton(
              text: "Давай почнемо",
              onPressed: () {
                Navigator.pushNamed(context, '/chooseRole');
              },
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
