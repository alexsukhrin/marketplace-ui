import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import '../themes/app_theme.dart';
import '../widgets/welcome_page_button.dart';

class GreetingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            SvgPicture.asset(
              'assets/Logo.svg',
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
                  color: Color(0xFF3B3B3B),
                  fontSize: 15,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 15),
          // Greeting Text
          Container(
            width: MediaQuery.of(context).size.width * 0.90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
                  ),
                ),
                Text(
                  "Давай спершу познайомимось?",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Full-Screen SVG
          Expanded(
            child: SvgPicture.asset(
              'assets/greeting_screen.svg',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          // Carousel Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 6,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFB6B6B6),
                  borderRadius: BorderRadius.circular(3), // Add rounded corners
                ),
              ),
              const SizedBox(width: 4),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Color(0xFFEFEFEF),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  color: Color(0xFFEFEFEF),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Button
          CustomButton(
            text: "Давай почнемо",
            onPressed: () {
              Navigator.pushNamed(context, '/chooseRole');
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
