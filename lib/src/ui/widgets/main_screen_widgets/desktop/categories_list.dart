import 'package:flutter/material.dart';
import '../../../../services/categories_service.dart';
import '../../../themes/app_theme.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, dynamic>> _categories = [];
  bool _expanded = false;
  final List<Color> _bgColors = [
    Color(0xFFF2F2F7),
    Color(0xFFECDFCC),
    Color(0xFFC2D0AF),
    Color(0xFFBED7DC),
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
    // Implement navigation logic here
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
      return Center(
          child: CircularProgressIndicator()); // Show a loader while fetching
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Категорії",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(displayCount, (index) {
            final category = _categories[index];
            final bgColor = _bgColors[index % _bgColors.length];

            return ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 110),
              // LayoutBuilder(builder: (context, constraints) {
              //   final screenWidth = constraints.maxWidth;
              //   final itemWidth = 110 + 16; // Category width + spacing
              //   final itemsPerRow =
              //       (screenWidth / itemWidth).floor(); // Max items that fit
              //   final displayCount = _categories.length < itemsPerRow
              //       ? _categories.length
              //       : itemsPerRow;

              //   return SizedBox(
              //     width: screenWidth, // Prevents overflow
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       children: List.generate(displayCount, (index) {
              //         final category = _categories[index];
              //         final bgColor = _bgColors[index % _bgColors.length];

              //         return Padding(
              //           padding: const EdgeInsets.only(right: 16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          category['photo'],
                          width: 94,
                          height: 108,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // print('Error loading image: $error');
                            // print('Stack trace: $stackTrace');
                            return Icon(Icons.image, size: 94);
                          },
                        ),
                        Text(
                          category['name'],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
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
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
