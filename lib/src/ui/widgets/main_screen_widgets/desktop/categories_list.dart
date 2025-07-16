import 'package:flutter/material.dart';
import '../../../../services/categories_service.dart';
import '../../../themes/app_theme.dart';
import '../../shared_widgets/title_text.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, dynamic>> _categories = [];
  bool _expanded = false;

  final List<Color> _bgColors = [
    const Color(0xFFC2D0AF),
    const Color(0xFFF2F2F7),
    const Color(0xFFF2F2F7),
    const Color(0xFFBED7DC),
    const Color(0xFFECDFCC),
    const Color(0xFFF2F2F7),
    const Color(0xFFBED7DC),
    const Color(0xFFECDFCC),
    const Color(0xFFF2F2F7),
    const Color(0xFFBED7DC),
    const Color(0xFFC2D0AF),
    const Color(0xFFECDFCC),
    const Color(0xFFC2D0AF),
  ];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await CategoryService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _navigateToCategory(int categoryId) {
    // navigation logic
    print('Navigating to category: $categoryId');
  }

  @override
  Widget build(BuildContext context) {
    // int displayCount =
    //     _expanded ? _categories.length : (_categories.length / 2).ceil();
    final screenWidth = MediaQuery.of(context).size.width;
    final itemsPerRow = (_categories.isNotEmpty && screenWidth >= 140)
        ? (screenWidth / 140).floor()
        : 1;
    final displayCount = _expanded
        ? _categories.length
        : (_categories.length < itemsPerRow ? _categories.length : itemsPerRow);

    if (_categories.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ReusableTextWidget(
          mainText: "Категорії",
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(displayCount, (index) {
            final category = _categories[index];
            final bgColor = _bgColors[index % _bgColors.length];

            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 110),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => _navigateToCategory(category['category_id']),
                  child: Container(
                    width: 110,
                    height: 156,
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              category['photo'],
                              width: 94,
                              height: 108,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.image, size: 94);
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              category['name'],
                              style: const TextStyle(fontSize: 14),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 40),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: _toggleExpanded,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.activeButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              _expanded ? "Показати менше" : "Показати більше",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
