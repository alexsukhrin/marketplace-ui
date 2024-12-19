import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/auth_widgets/auth_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
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
            const Column(
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
            ),

            const SizedBox(height: 35),
            // Button
            AuthButton(
              text: "Зареєструватись",
              onPressed: () {
                Navigator.pushNamed(context, '/registration');
              },
            ),
            const SizedBox(height: 8),
            // Outlined Button (Увійти)
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.transparent,
                side: BorderSide(
                  color: AppTheme.activeButtonColor,
                  width: 1,
                ),
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Увійти",
                style: TextStyle(
                  fontSize: 16,
                  color: AppTheme.activeButtonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
