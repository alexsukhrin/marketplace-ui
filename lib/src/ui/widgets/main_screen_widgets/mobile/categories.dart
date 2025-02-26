import 'package:flutter/material.dart';
import '../../../../services/categories_service.dart';
import '../../../themes/app_theme.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Категорії',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/categories');
                },
                child: const Text(
                  'Дивитись усі',
                  style: TextStyle(
                    color: AppTheme.lightBodyColor,
                    fontSize: 15,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          FutureBuilder<List<Map<String, dynamic>>>(
            future: CategoryService.getCategories(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError ||
                  !snapshot.hasData ||
                  snapshot.data!.isEmpty) {
                return const Center(child: Text('No categories available.'));
              } else {
                final categories = snapshot.data!.take(3).toList();
                final List<Color> categoryColors = [
                  const Color(0xFFF2F2F7),
                  const Color(0xFFECDFCC),
                  const Color(0xFFC2D0AF),
                ];

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (index) {
                      final category = categories[index];
                      final categoryName = category['name'];
                      final categoryImageUrl = category['photo'] ?? "";
                      final categoryColor = categoryColors[index];

                      return Padding(
                        padding: EdgeInsets.only(
                            right: index < categories.length - 1 ? 12.0 : 0),
                        child: Container(
                          width: 148,
                          height: 156,
                          decoration: BoxDecoration(
                            color: categoryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  width: 132,
                                  height: 108,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      categoryImageUrl,
                                      width: 132,
                                      height: 108,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Center(
                                          child: Icon(Icons.broken_image,
                                              size: 50, color: Colors.grey),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          categoryName,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.chevron_right,
                                        size: 24,
                                        color: Colors.orange,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
