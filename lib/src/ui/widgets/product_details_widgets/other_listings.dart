import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/favorite_button.dart';

class OtherListings extends StatelessWidget {
  final List<Map<String, dynamic>> listings;

  const OtherListings({super.key, required this.listings});

  @override
  Widget build(BuildContext context) {
    final displayedListings = listings.take(5).toList();

    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Інші оголошення продавця',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 199,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: displayedListings
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: _buildProductCard(item),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(158, 40),
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Дивитись усі'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> item) {
    return SizedBox(
      width: 235,
      child: SizedBox(
        height: 199,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 128,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(8)),
                    image: DecorationImage(
                      image: AssetImage(item['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Positioned(
                  top: 8,
                  right: 8,
                  child: FavoriteButton(borderColor: Colors.white),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    item['status'],
                    style:
                        const TextStyle(fontSize: 15, color: Color(0xFF464646)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item['price']} uah',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
