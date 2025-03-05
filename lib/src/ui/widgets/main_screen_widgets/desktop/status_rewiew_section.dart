import 'package:flutter/material.dart';
import '../../../themes/app_theme.dart';

class StatsAndReviewsSection extends StatelessWidget {
  final List<Map<String, String>> stats = [
    {"label": "Цілодобова\nпідтримка", "value": "24/7"},
    {"label": "Верифікаованих\nпродавців", "value": "1000+"},
    {"label": "Успішних\nпродажів", "value": "430+"},
  ];

  final List<Map<String, String>> reviews = [
    {
      "photo": "assets/images/main_icons/user_mock_photo.png",
      "name": "Вікторія Бучко",
      "role": "Покупець",
      "review":
          "Я є активним покупцем Shum. Подобається усе! Особливо верифікація, бо це безпека.",
    },
    {
      "name": "Вікторія Бучко",
      "role": "Покупець",
      "review": "Я є активним покупцем Shum. Подобається усе! ",
    },
  ];

  StatsAndReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title Section
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Відгуки",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Дізнайтесь про думки та досвід наших користувачів",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Orange Stats & Reviews Container
        Container(
          decoration: BoxDecoration(
            color: AppTheme.activeBorderColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Side
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: stats.map((stat) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 50, top: 40, bottom: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stat["label"]!,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: AppTheme.witeText,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            stat["value"]!,
                            style: const TextStyle(
                              color: AppTheme.witeText,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),

              // Right Side: Reviews
              Expanded(
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(reviews.length, (index) {
                      final review = reviews[index];
                      return Expanded(
                        //white box
                        child: Container(
                          padding: const EdgeInsets.only(left: 15, bottom: 15),
                          decoration: BoxDecoration(
                            color: AppTheme.witeText,
                            borderRadius: index == 0
                                ? const BorderRadius.only(
                                    bottomLeft: Radius.circular(12))
                                : BorderRadius.zero,
                          ),
                          //grey box inside
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppTheme.greyBoxColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // User Image Placeholder
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[300],
                                      ),
                                      child: review.containsKey("photo") &&
                                              review["photo"] != null
                                          ? ClipOval(
                                              child: Image.asset(
                                                review["photo"]!,
                                                fit: BoxFit.cover,
                                                width: 44,
                                                height: 44,
                                              ),
                                            )
                                          : const Icon(
                                              Icons.person,
                                              size: 24,
                                              color: AppTheme.witeText,
                                            ),
                                    ),

                                    const SizedBox(width: 10),

                                    // Name & Role
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          review["name"]!,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          review["role"]!,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),

                                // Review Text
                                Text(
                                  review["review"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: AppTheme.blackText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
