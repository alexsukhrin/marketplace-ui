import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/about_seller.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/image_slider.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/other_listings.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/product_info.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> mockListings = [
      {
        'image': 'assets/images/product_details_moc_img/moc_img1.png',
        'title': 'Смартфон Samsung A54',
        'status': 'Новий',
        'price': 599
      },
      {
        'image': 'assets/images/product_details_moc_img/moc_img2.png',
        'title': 'Ноутбук Lenovo ThinkPad',
        'status': 'Б/у',
        'price': 899
      },
      {
        'image': 'assets/images/product_details_moc_img/moc_img3.png',
        'title': 'Навушники AirPods Pro',
        'status': 'Новий',
        'price': 199
      },
      {
        'image': 'assets/images/product_details_moc_img/moc_img4.png',
        'title': 'Геймерська мишка Logitech',
        'status': 'Новий',
        'price': 79
      },
      {
        'image': 'assets/images/product_details_moc_img/moc_img5.png',
        'title': 'Клавіатура механічна',
        'status': 'Б/у',
        'price': 120
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 582,
              child: ImageSlider(
                images: List<String>.from(
                  (product['photos'] as List<dynamic>)
                      .map((photo) => photo['url']),
                ),
              ),
            ),
            const SizedBox(width: 70),
            Expanded(child: ProductInfo(product: product)),
          ],
        ),
        const SizedBox(height: 44),
        const AboutSeller(),
        OtherListings(listings: mockListings),
      ],
    );
  }
}
