import 'package:flutter/material.dart';
import '../../../services/categories_service.dart';
import '../../themes/app_theme.dart';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({super.key});

  @override
  AllCategoriesPageState createState() => AllCategoriesPageState();
}

class AllCategoriesPageState extends State<AllCategoriesPage> {
  late Future<List<Map<String, dynamic>>> _categoriesFuture;

  final List<Color> darkCategoryColors = [
    const Color(0xFFC2D0AF),
    const Color(0xFFF2F2F7),
    const Color(0xFFF2F2F7),
    const Color(0xFFBED7DC),
    const Color(0xFFECDFCC),
    const Color(0xFFF2F2F7),
    const Color(0xFFBED7DC),
    const Color(0xFFECDFCC),
    const Color(0xFFF2F2F7),
    const Color(0xFFC2D0AF),
    const Color(0xFFECDFCC),
    const Color(0xFFC2D0AF),
    const Color(0xFFBED7DC),
  ];

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryService.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    int crossAxisCount = 3;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Категорії',
          style: textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _categoriesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.splashColor,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No categories available.'));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 110 / 156,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final category = snapshot.data![index];
                  final categoryName = category['name'];
                  final categoryImageUrl = category['photo'] ?? "";

                  final darkColor =
                      darkCategoryColors[index % darkCategoryColors.length];

                  return Container(
                    width: 110,
                    height: 156,
                    decoration: BoxDecoration(
                      color: darkColor,
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
                            width: 112,
                            height: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  categoryImageUrl,
                                  width: 108,
                                  height: 130,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    }
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(Icons.broken_image,
                                          size: 50, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 112,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    categoryName,
                                    style: textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w300),
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
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
