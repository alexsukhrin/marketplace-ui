import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ReviewWidget({super.key, this.reviews = const []});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Center(
        child: Text(
          'Продавець ще немає жодного відгуку',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    ScrollController controller = ScrollController();

    return SizedBox(
      width: double.infinity,
      child: Scrollbar(
        thumbVisibility: true,
        controller: controller,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: controller,
          child: Row(
            children:
                reviews.map((review) => _buildReviewItem(review)).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem(Map<String, dynamic> review) {
    return Container(
      width: 408,
      height: 85,
      margin: const EdgeInsets.only(top: 20, right: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(128, 128, 128, 0.2),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        review['name'],
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(5, (index) {
                        bool isFilled = index < review['rating'];
                        return Icon(
                          isFilled ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 16,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  review['text'],
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
