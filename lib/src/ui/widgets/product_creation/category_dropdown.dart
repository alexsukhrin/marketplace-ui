import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CategoryDropdown extends StatefulWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String?) onCategorySelected;
  final String hintText;
  final String? value;

  const CategoryDropdown({
    super.key,
    required this.categories,
    required this.onCategorySelected,
    required this.hintText,
    this.value,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? selectedValue;
  bool isDropdownOpen = false;

  final _dropdownButtonKey = GlobalKey<DropdownButton2State>();

  @override
  void initState() {
    super.initState();
    if (widget.value != null &&
        widget.categories
            .any((c) => c['category_id'].toString() == widget.value)) {
      selectedValue = widget.value;
    } else {
      selectedValue = null;
    }
  }

  @override
  void didUpdateWidget(covariant CategoryDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      if (widget.value != null &&
          widget.categories
              .any((c) => c['category_id'].toString() == widget.value)) {
        setState(() {
          selectedValue = widget.value;
        });
      } else {
        setState(() {
          selectedValue = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      key: _dropdownButtonKey,
      isExpanded: true,
      value: selectedValue,
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down, color: Colors.transparent, size: 0),
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.textFieldBackgroundColor,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: Icon(
          isDropdownOpen ? Icons.expand_less : Icons.expand_more,
          color: AppTheme.linkTextColor,
        ),
      ),
      items: widget.categories.map((category) {
        return DropdownMenuItem<String>(
          value: category['category_id'].toString(),
          child: Text(
            category['name'],
            style: const TextStyle(fontSize: 14),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onCategorySelected(value);
      },
      onMenuStateChange: (isOpen) {
        setState(() {
          isDropdownOpen = isOpen;
        });
      },
      dropdownStyleData: DropdownStyleData(
        maxHeight: 250,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: AppTheme.textFieldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 2,
        offset: const Offset(0, -2),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 36,
        padding: EdgeInsets.symmetric(horizontal: 12),
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
