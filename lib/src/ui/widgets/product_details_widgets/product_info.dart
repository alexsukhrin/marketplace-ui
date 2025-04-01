import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/favorite_button.dart';
import 'package:flutter_application_1/src/ui/widgets/product_details_widgets/product_details_button.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({super.key});

  @override
  ProductInfoState createState() => ProductInfoState();
}

class ProductInfoState extends State<ProductInfo> {
  String? selectedSize = '36';
  bool isFavoriteHovered = false;
  bool isTimelineHovered = false;

  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 588,
      height: 509,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Vans off the wall',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  FavoriteButton(
                    borderColor: Colors.black,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.timeline,
                    color: Colors.black,
                    size: 24,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Бренд: ',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 8),
              Container(
                width: 43,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'Vans',
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text(
                'Розмір',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 8),
              Container(
                width: 37,
                height: 22,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: DropdownButton<String>(
                    value: selectedSize,
                    items: [
                      '35',
                      '36',
                      '37',
                      '38',
                      '39',
                      '40',
                      '41',
                      '42',
                      '43',
                      '44'
                    ].map((size) {
                      return DropdownMenuItem<String>(
                        value: size,
                        child: Text(
                          size,
                          style: const TextStyle(fontSize: 14),
                        ),
                      );
                    }).toList(),
                    onChanged: (newSize) {
                      setState(() {
                        selectedSize = newSize;
                      });
                    },
                    underline: const SizedBox(),
                    isExpanded: false,
                    hint: const Text(
                      '36',
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: const SizedBox.shrink(),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '2399 ₴',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text(
            'Опис',
            style: TextStyle(fontSize: 14),
          ),
          const Divider(
            color: Color(0xFFEFEFEF),
            thickness: 1,
          ),
          const SizedBox(height: 8),
          const Text(
            'Продаю нові кросівки, фірма Vans. Причина продажу - не підійшов розмір. Відправлю завтра.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            'Додаткової інформація',
            style: TextStyle(fontSize: 14),
          ),
          const Divider(
            color: Color(0xFFEFEFEF),
            thickness: 1,
          ),
          const SizedBox(height: 8),
          const Text(
            'Куплені в оригінальному магазині. Рік 2023.',
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ProductDetailsButton(
                text: 'В кошик',
                onPressed: () {},
                width: 141,
                height: 40,
                hasIcon: true,
                iconData: Icons.shopping_basket,
              ),
              const SizedBox(width: 8),
              ProductDetailsButton(
                text: 'Написати продавцю',
                onPressed: () {},
                width: 201,
                height: 40,
              ),
            ],
          ),
          const SizedBox(height: 8),
          ProductDetailsButton(
            text: 'Купити товар',
            onPressed: () {},
            width: 350,
            height: 40,
            isPrimary: true,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
