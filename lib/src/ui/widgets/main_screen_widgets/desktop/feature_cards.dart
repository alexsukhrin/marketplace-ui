import 'package:flutter/material.dart';

import '../../../themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeaturesSection extends StatelessWidget {
  final List<Map<String, String>> features = [
    {
      "iconPath": "assets/images/main_icons/shield_tick.svg",
      "title": "Ми дбаємо про вашу безпеку",
      "description":
          "Тому запровадили верифікацію та багато іншого для підтвердження осіб",
    },
    {
      "iconPath": "assets/images/main_icons/24_support.svg",
      "title": "Цілодобова підтримка",
      "description":
          "Ми цінуємо, що ви обираєте нас, тому готові допомогти у будь-який час доби",
    },
    {
      "iconPath": "assets/images/main_icons/shield_tick.svg",
      "title": "Ми дбаємо про вашу безпеку",
      "description":
          "Тому запровадили верифікацію та багато іншого для підтвердження осіб",
    },
  ];

  FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top text section
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Чому варто обрати нас",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Дізнайтесь про наші особливості",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Features section inside a box
        Container(
          decoration: BoxDecoration(
            color: AppTheme.activeBorderColor,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: features
                .map(
                  (feature) => Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 7),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppTheme.activeBorderColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    feature["iconPath"]!,
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      feature["title"]!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      feature["description"]!,
                                      style: const TextStyle(fontSize: 14),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
