import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class CategoryDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String?) onCategorySelected;
  final String hintText;

  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    required this.hintText,
  });

  @override
  _CategoryDropdownState createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? selectedCategory;
  bool isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCategory,
      icon: const Visibility(visible: false, child: Icon(Icons.arrow_downward)),
      items: widget.categories.isEmpty
          ? [
              const DropdownMenuItem(
                child: Text('Немає варіантів'),
              )
            ]
          : widget.categories.map<DropdownMenuItem<String>>(
              (category) {
                return DropdownMenuItem<String>(
                  value: category['category_id'].toString(),
                  child: Text(category['name']),
                );
              },
            ).toList(),
      hint: Text(
        widget.hintText,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppTheme.hintTesxtGrey,
        ),
      ),
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
          isDropdownOpen = !isDropdownOpen;
        });
        widget.onCategorySelected(value);
      },
      decoration: InputDecoration(
        hintText: 'Усі категорії тут',
        fillColor: AppTheme.textFieldBackgroundColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.activeBorderColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.textError,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.textError,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: Icon(
          isDropdownOpen ? Icons.expand_less : Icons.expand_more,
          color: AppTheme.linkTextColor,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Вибір є обовʼязковим';
        }
        return null;
      },
    );
  }
}
