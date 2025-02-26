import 'package:flutter/material.dart';

import '../../../../services/categories_service.dart';
import '../../../themes/app_theme.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  List<Map<String, dynamic>> categories = [];
  bool isOpen = false;
  String selectedCategory = 'Категорії';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final fetchedCategories = await CategoryService.getCategories();
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Aligns dropdown to left
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Row(
            children: [
              Text(
                selectedCategory,
                style: TextStyle(
                  fontSize: 16,
                  color: isOpen ? AppTheme.splashColor : Colors.black,
                ),
              ),
              const SizedBox(width: 3),
              AnimatedRotation(
                duration: const Duration(milliseconds: 200),
                turns: isOpen ? 0.5 : 0,
                child: Icon(
                  Icons.expand_more,
                  size: 18,
                  color: isOpen ? AppTheme.splashColor : Colors.black,
                ),
              ),
            ],
          ),
        ),
        if (isOpen)
          SizedBox(
            width: 179, // Set the width of the dropdown to 179px
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              decoration: BoxDecoration(
                color: AppTheme.sidebarColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: categories.map((category) {
                  bool isSelected = selectedCategory == category['name'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['name'];
                        isOpen = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: isSelected
                          ? BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(8),
                            )
                          : null,
                      child: Row(
                        children: [
                          // Placeholder for icon (removed for now)
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              category['name'],
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    isSelected ? Colors.orange : Colors.black,
                              ),
                              softWrap: true, // Allow wrapping of the text
                              overflow: TextOverflow
                                  .ellipsis, // Add ellipsis when text overflows
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
