import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';

import '../../widgets/custom_button.dart';
import '../../widgets/welcome_page_widgets/custom_outlined_button.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  _SelectCategoryScreenState createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  final List<String> categories = [
    "Електроніка",
    "Взуття",
    "Одяг",
    "Для тварин",
    "Для дітей",
    "Для спорту",
    "Канцелярія",
    "Автотовари",
    "Догляд",
    "Для дому",
    "Для активного відпочинку",
    "Книги",
    "Для саду",
    "Інше",
  ];

  final Set<String> selectedCategories = {};

  void toggleCategory(String category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category); // Deselect category
      } else {
        selectedCategories.add(category); // Select category
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WelcomePageHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Яким категоріям надаєш\nперевагу?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Твої відповіді допоможуть нам підібрати найкращі товари для тебе.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 36),
            Wrap(
              spacing: 10, // Horizontal space between buttons
              runSpacing: 10, // Vertical space between rows of buttons
              children: categories.map((category) {
                final isSelected = selectedCategories.contains(category);
                return CustomOutlinedButton(
                  text: category,
                  onPressed: () => toggleCategory(category),
                  isSelected: isSelected,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 6,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB6B6B6),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            CustomButton(
              text: "На головну сторінку",
              onPressed: () {
                Navigator.pushNamed(context, '/mainScreen');
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
