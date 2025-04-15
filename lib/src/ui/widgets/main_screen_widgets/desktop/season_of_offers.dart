import 'package:flutter/material.dart';

import '../../../themes/app_theme.dart';
import '../../shared_widgets/title_text.dart';

class SeasonalOffersWidget extends StatelessWidget {
  final List<Map<String, String>> seasonalOffers = [
    {
      "name": "Літні товари",
      "image": "./../../../../../../assets/images/main_icons/mock_photo3.png"
    },
    {
      "name": "Осінні товари",
      "image": "./../../../../../../assets/images/main_icons/mock_photo.png"
    },
    {
      "name": "Зимові товари",
      "image": "./../../../../../../assets/images/main_icons/mock_photo2.png"
    },
    {
      "name": "Весняні товари",
      "image": "./../../../../../../assets/images/main_icons/mock_photo4.png"
    },
    {
      "name": "Для школи",
      "image": "./../../../../../../assets/images/main_icons/mock_photo5.png"
    },
  ];

  SeasonalOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(
          mainText: "Сезонні пропозиції",
          secondaryText: "Підібрані товари на кожен сезон",
        ),
        const SizedBox(height: 15),
        LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;
            int itemsPerRow = (availableWidth / (243 + 10)).floor();
            double totalWidth = itemsPerRow * (243 + 10) - 10;
            return SizedBox(
              width: totalWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // seasonalOffers.take(itemsPerRow).map((offer) {
                  for (int i = 0; i < itemsPerRow; i++) ...[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            width: 235,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8)),
                                  child: Image.network(
                                    // offer['image']!,
                                    seasonalOffers[i]['image']!,
                                    width: 235,
                                    height: 128,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // offer['name']!,
                                        seasonalOffers[i]['name']!,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        size: 24,
                                        color: AppTheme.activeButtonColor,
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
                    if (i != itemsPerRow - 1) SizedBox(width: 10),
                  ]
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.activeButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {},
            child: const Text(
              'Дивитись усі',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
