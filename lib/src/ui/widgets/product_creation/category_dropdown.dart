import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

// class CategoryDropdown extends StatefulWidget {
//   final List<Map<String, dynamic>> categories;
//   final Function(String?) onCategorySelected;
//   final String hintText;

//   const CategoryDropdown({
//     super.key,
//     required this.categories,
//     required this.onCategorySelected,
//     required this.hintText,
//   });

//   @override
//   _CategoryDropdownState createState() => _CategoryDropdownState();
// }

// class _CategoryDropdownState extends State<CategoryDropdown> {
//   String? selectedCategory;
//   bool isDropdownOpen = false;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<String>(
//       value: selectedCategory,
//       icon: const Visibility(visible: false, child: Icon(Icons.arrow_downward)),
//       items: widget.categories.isEmpty
//           ? [
//               const DropdownMenuItem(
//                 child: Text('Немає варіантів'),
//               )
//             ]
//           : widget.categories.map<DropdownMenuItem<String>>(
//               (category) {
//                 return DropdownMenuItem<String>(
//                   value: category['category_id'].toString(),
//                   child: Text(category['name']),
//                 );
//               },
//             ).toList(),
//       hint: Text(
//         widget.hintText,
//         style: const TextStyle(
//           fontSize: 14,
//           fontWeight: FontWeight.w400,
//           color: AppTheme.hintTesxtGrey,
//         ),
//       ),
//       onChanged: (value) {
//         setState(() {
//           selectedCategory = value;
//           isDropdownOpen = !isDropdownOpen;
//         });
//         widget.onCategorySelected(value);
//       },
//       decoration: InputDecoration(
//         hintText: 'Усі категорії тут',
//         fillColor: AppTheme.textFieldBackgroundColor,
//         filled: true,
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: Colors.transparent,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: AppTheme.activeBorderColor,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: AppTheme.textError,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: const BorderSide(
//             color: AppTheme.textError,
//           ),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         suffixIcon: Icon(
//           isDropdownOpen ? Icons.expand_less : Icons.expand_more,
//           color: AppTheme.linkTextColor,
//         ),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Вибір є обовʼязковим';
//         }
//         return null;
//       },
//     );
//   }
// }

import 'package:dropdown_button2/dropdown_button2.dart';

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
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  String? selectedValue;
  bool isDropdownOpen = false;

  final _dropdownButtonKey = GlobalKey<DropdownButton2State>();

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
