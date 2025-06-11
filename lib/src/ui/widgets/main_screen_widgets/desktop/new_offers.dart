import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';

import '../../../../services/product_service.dart';
import '../../shared_widgets/title_text.dart';

class NewOffersWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductTap;
  const NewOffersWidget({super.key, required this.onProductTap});

  @override
  NewOffersWidgetState createState() => NewOffersWidgetState();
}

class NewOffersWidgetState extends State<NewOffersWidget> {
  List<dynamic> newOffers = [];
  List<bool> isFavorite = [];

  @override
  void initState() {
    super.initState();
    fetchLatestOffers();
  }

  Future<void> fetchLatestOffers() async {
    try {
      final products = await ProductService.fetchProducts();
      final latest = products.take(5).toList();
      setState(() {
        newOffers = latest;
        isFavorite = List<bool>.filled(latest.length, false);
      });
    } catch (e) {
      print('Error loading latest offers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (newOffers.isEmpty) {
      return const Center(child: Text('Немає нових товарів'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(
          mainText: "Нові оголошення",
          secondaryText: "Перегляньте ці товари першими",
        ),
        const SizedBox(height: 15),
        LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;
            int itemsPerRow = (availableWidth / (243 + 10)).floor();
            int displayCount = newOffers.length.clamp(0, itemsPerRow);
            double totalWidth = displayCount * (243 + 10) - 8;

            return SizedBox(
              width: totalWidth,
              child: Row(
                children: List.generate(displayCount, (i) {
                  final product = newOffers[i];
                  final imageUrl = product['photos']?.isNotEmpty == true
                      ? product['photos'][0]['url']
                      : 'https://via.placeholder.com/235x128';

                  return Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GestureDetector(
                      onTap: () {
                        widget.onProductTap(product);
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: SizedBox(
                          width: 235,
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    child: Image.network(
                                      imageUrl,
                                      width: 235,
                                      height: 128,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['title'] ?? 'Без назви',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          product['condition'] == 'USED'
                                              ? 'б/у'
                                              : 'нове',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0xFF464646),
                                          ),
                                        ),
                                        Text(
                                          '${product['price']} UAH',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
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
                                      isFavorite[i] = !isFavorite[i];
                                    });
                                  },
                                  child: Icon(
                                    isFavorite[i]
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite[i]
                                        ? AppTheme.activeButtonColor
                                        : AppTheme.backgroundColorWhite,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
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
