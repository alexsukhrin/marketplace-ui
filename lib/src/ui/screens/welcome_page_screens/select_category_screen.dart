import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';

import '../../../services/categories_service.dart';
import '../../widgets/auth_widgets/auth_button.dart';
import '../../widgets/welcome_page_widgets/custom_outlined_button.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  SelectCategoryScreenState createState() => SelectCategoryScreenState();
}

class SelectCategoryScreenState extends State<SelectCategoryScreen> {
  List<Map<String, dynamic>> categories =
      []; // Updated to store both name and id
  List<Map<String, dynamic>> selectedCategories =
      []; // Updated for selected categories
  bool isLoading = true; // Loading state for fetching categories

  @override
  void initState() {
    super.initState();
    print('Fetching categories...');
    fetchCategories();
  }

// Fetch categories from the backend
  Future<void> fetchCategories() async {
    try {
      final fetchedCategories = await CategoryService.getCategories();
      setState(() {
        categories = fetchedCategories;
        isLoading = false;
      });
      print(categories);
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load categories: $e')),
      );
    }
  }

  // Toggle category selection
  void toggleCategory(Map<String, dynamic> category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

// Submit selected categories to the backend
  Future<void> submitCategories() async {
    try {
      await CategoryService.submitCategories(selectedCategories);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categories submitted successfully!')),
      );

      // Navigate to the main page or desired screen
      Navigator.pushNamed(context, '/main');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit categories: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WelcomePageHeader(
        routeName: '/main',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Яким категоріям надаєш\nперевагу?",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Твої відповіді допоможуть нам підібрати найкращі товари для тебе.",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 36),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((category) {
                final isSelected = selectedCategories.contains(category);
                return CustomOutlinedButton(
                  text: category['name'],
                  onPressed: () => toggleCategory(category),
                  isSelected: isSelected,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            const Spacer(),
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
            Center(
              child: Column(
                children: [
                  AuthButton(
                    text: "На головну сторінку",
                    onPressed: submitCategories,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
