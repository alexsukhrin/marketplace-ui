import 'package:flutter/material.dart';
import '../../../../utils/auth_validator.dart';
import '../../../themes/app_theme.dart';

class TokenBasedBanner extends StatelessWidget {
  const TokenBasedBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return TokenBasedWidget(child: MarqueeBanner());
  }
}

class MarqueeBanner extends StatelessWidget {
  final List<String> words = [
    "Завантажуй застосунок",
    "Обирай",
    "Купуй",
    "Безпечно",
    "Швидко",
    "Вигідно"
  ];

  MarqueeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      color: AppTheme.linkTextColor,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              50,
              (index) => Row(
                children: [
                  Text(
                    words[index % words.length],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
