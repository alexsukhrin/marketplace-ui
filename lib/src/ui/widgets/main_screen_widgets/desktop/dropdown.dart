// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../themes/app_theme.dart';

// class CategoriesDropdown extends StatefulWidget {
//   const CategoriesDropdown({super.key});

//   @override
//   State<CategoriesDropdown> createState() => _CategoriesDropdownState();
// }

// class _CategoriesDropdownState extends State<CategoriesDropdown> {
//   String? _selectedCategory;

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton<String>(
//         value: _selectedCategory,
//         hint: const Row(
//           children: [
//             Text(
//               'Категорії',
//               style: TextStyle(fontSize: 16, color: Colors.black),
//             ),
//             SizedBox(width: 4),
//             Icon(
//               Icons.expand_more,
//               color: Colors.black,
//               size: 20,
//             ),
//           ],
//         ),
//         icon: SizedBox.shrink(),
//         dropdownColor: AppTheme.sidebarColor,
//         itemHeight: 48,
//         isExpanded: false,
//         // alignment: Alignment.centerLeft,
//         onChanged: (value) {
//           setState(() {
//             _selectedCategory = value;
//           });
//         },
//         items: [
//           _buildDropdownItem('Взуття',
//               'assets/images/main_icons/categories_dropdown/activity_icon.svg'),
//           _buildDropdownItem('Одяг',
//               'assets/images/main_icons/categories_dropdown/activity_icon.svg'),
//           _buildDropdownItem('Для дому',
//               'assets/images/main_icons/categories_dropdown/activity_icon.svg'),
//           _buildDropdownItem('Техніка',
//               'assets/images/main_icons/categories_dropdown/activity_icon.svg'),
//           _buildDropdownItem('Для саду',
//               'assets/images/main_icons/categories_dropdown/activity_icon.svg'),
//         ],
//         menuMaxHeight: 300,
//       ),
//     );
//   }

//   DropdownMenuItem<String> _buildDropdownItem(String text, String iconPath) {
//     return DropdownMenuItem(
//         value: text,
//         child: SizedBox(
//           // width: 179,
//           child: Row(
//             children: [
//               SvgPicture.asset(
//                 iconPath,
//                 width: 20,
//                 height: 20,
//               ),
//               const SizedBox(width: 8),
//               Text(
//                 text,
//                 style: const TextStyle(fontSize: 15, color: Colors.black),
//               ),
//             ],
//           ),
//         ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../themes/app_theme.dart';

class CategoryDropdown extends StatefulWidget {
  const CategoryDropdown({super.key});

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Взуття',
      'icon': 'assets/images/main_icons/categories_dropdown/activity_icon.svg'
    },
    {
      'name': 'Одяг',
      'icon': 'assets/images/main_icons/categories_dropdown/books.svg'
    },
    {
      'name': 'Для дому',
      'icon': 'assets/images/main_icons/categories_dropdown/icon2.svg'
    },
    {
      'name': 'Техніка',
      'icon': 'assets/images/main_icons/categories_dropdown/icon3.svg'
    },
    {
      'name': 'Для саду',
      'icon': 'assets/images/main_icons/categories_dropdown/garden.svg'
    },
    {
      'name': 'Книги',
      'icon': 'assets/images/main_icons/categories_dropdown/books.svg'
    },
    {
      'name': 'Автотовари',
      'icon': 'assets/images/main_icons/categories_dropdown/icon6.svg'
    },
    {
      'name': 'Спорт',
      'icon': 'assets/images/main_icons/categories_dropdown/sport.svg'
    },
    {
      'name': 'Догляд',
      'icon': 'assets/images/main_icons/categories_dropdown/icon8.svg'
    },
    {
      'name': 'Для тварин',
      'icon': 'assets/images/main_icons/categories_dropdown/pets.svg'
    },
    {
      'name': 'Канцелярія',
      'icon': 'assets/images/main_icons/categories_dropdown/icon1.svg'
    },
    {
      'name': 'Для дітей',
      'icon': 'assets/images/main_icons/categories_dropdown/icon1.svg'
    },
    {
      'name': 'Активності',
      'icon': 'assets/images/main_icons/categories_dropdown/icon1.svg'
    },
  ];

  bool isOpen = false;
  String selectedCategory = 'Категорії';

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
          Container(
            margin: const EdgeInsets.only(top: 30),
            // padding: const EdgeInsets.symmetric(vertical: 8,),
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
                        SvgPicture.asset(
                          category['icon'],
                          height: 20,
                          width: 20,
                          colorFilter: ColorFilter.mode(
                            isSelected ? Colors.orange : Colors.black,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          category['name'],
                          style: TextStyle(
                            fontSize: 16,
                            color: isSelected ? Colors.orange : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
