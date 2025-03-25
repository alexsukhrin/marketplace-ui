import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';

class NewOffersWidget extends StatefulWidget {
  const NewOffersWidget({super.key});

  @override
  _NewOffersWidgetState createState() => _NewOffersWidgetState();
}

class _NewOffersWidgetState extends State<NewOffersWidget> {
  final List<Map<String, String>> newOffers = [
    {
      "name": "Покривало",
      "image": "./../../../../../../assets/images/main_icons/mock_photo3.png",
      "condition": "Нове",
      "price": "530 UAH"
    },
    {
      "name": "Парасоля",
      "image": "./../../../../../../assets/images/main_icons/mock_photo.png",
      "condition": "Нове",
      "price": "450 UAH"
    },
    {
      "name": "Новорічні іграшки",
      "image": "./../../../../../../assets/images/main_icons/mock_photo2.png",
      "condition": "Нове",
      "price": "350 UAH"
    },
    {
      "name": "Шляпа",
      "image": "./../../../../../../assets/images/main_icons/mock_photo4.png",
      "condition": "Нове",
      "price": "320 UAH"
    },
    {
      "name": "Олівці",
      "image": "./../../../../../../assets/images/main_icons/mock_photo5.png",
      "condition": "Нове",
      "price": "530 UAH"
    },
  ];

  List<bool> isFavorite = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Нові оголошення",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Перегляньте ці товари першими",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
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
                  for (int i = 0; i < itemsPerRow; i++) ...[
                    Expanded(
                      child: SizedBox(
                        width: 235,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(8)),
                                  child: Image.network(
                                    newOffers[i]['image']!,
                                    width: 235,
                                    height: 128,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Handle the click on the text below the image
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          newOffers[i]['name']!,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          newOffers[i]['condition']!,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF464646),
                                          ),
                                        ),
                                        Text(
                                          newOffers[i]['price']!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 6,
                              right: 14,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Toggle the favorite state
                                    isFavorite[i] = !isFavorite[i];
                                  });
                                },
                                child: Icon(
                                  isFavorite[i]
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite[i]
                                      ? AppTheme.activeButtonColor
                                      : const Color.fromARGB(255, 35, 34, 34),
                                  size: 28,
                                ),
                              ),
                            ),
                          ],
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
