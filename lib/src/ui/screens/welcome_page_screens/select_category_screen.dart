import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';

import '../../../services/categories_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/responsive/responsive_design.dart';
import '../../widgets/welcome_page_widgets/custom_outlined_button.dart';
import '../../widgets/welcome_page_widgets/left_section.dart';
import '../../widgets/welcome_page_widgets/progress_indicator.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  SelectCategoryScreenState createState() => SelectCategoryScreenState();
}

class SelectCategoryScreenState extends State<SelectCategoryScreen> {
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> selectedCategories = [];
  bool isLoading = true;

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
      body: TResponsiveWidget(
        desktop: Padding(
          padding: const EdgeInsets.symmetric(vertical: 33.0, horizontal: 61.0),
          child: Desktop(
            categories: categories,
            selectedCategories: selectedCategories,
            toggleCategory: toggleCategory,
            submitCategories: submitCategories,
          ),
        ),
        tablet: Tablet(),
        mobile: Mobile(
          categories: categories,
          selectedCategories: selectedCategories,
          toggleCategory: toggleCategory,
          submitCategories: submitCategories,
        ),
      ),
    );
  }
}

class CategorySelectionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> selectedCategories;
  final Function(Map<String, dynamic>) toggleCategory;
  final CrossAxisAlignment crossAxisAlignment;

  const CategorySelectionWidget({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.toggleCategory,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
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
          "Твої відповіді допоможуть нам підібрати найкращі пропозиції для тебе.",
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
      ],
    );
  }
}

class Desktop extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> selectedCategories;
  final Function(Map<String, dynamic>) toggleCategory;
  final Function() submitCategories;

  const Desktop({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.toggleCategory,
    required this.submitCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const LeftSection(
              imagePath: 'assets/images/welcome_page/choose_role_screen.svg'),

          // Right Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip
                  const WelcomePageHeader(
                    routeName: '/main',
                  ),

                  // Main Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CategorySelectionWidget(
                        categories: categories,
                        selectedCategories: selectedCategories,
                        toggleCategory: toggleCategory,
                        crossAxisAlignment: CrossAxisAlignment.center,
                      ),
                      const SizedBox(height: 36),
                      SubmitCategoriesButton(submitCategories: submitCategories)
                    ],
                  ),

                  const ProgressIndicatorRow(order: [
                    "inactive",
                    "space",
                    "inactive",
                    "space",
                    "active"
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Mobile extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final List<Map<String, dynamic>> selectedCategories;
  final Function(Map<String, dynamic>) toggleCategory;
  final Function() submitCategories;

  const Mobile({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.toggleCategory,
    required this.submitCategories,
  });

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
            CategorySelectionWidget(
              categories: categories,
              selectedCategories: selectedCategories,
              toggleCategory: toggleCategory,
            ),
            const SizedBox(height: 24),
            const Spacer(),
            const ProgressIndicatorRow(
                order: ["inactive", "space", "inactive", "space", "active"]),
            const SizedBox(height: 14),
            Center(
              child: Column(
                children: [
                  SubmitCategoriesButton(submitCategories: submitCategories),
                ],
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

class SubmitCategoriesButton extends StatelessWidget {
  final Function() submitCategories;

  const SubmitCategoriesButton({
    super.key,
    required this.submitCategories,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "На головну сторінку",
      onPressed: submitCategories,
      buttonType: ButtonType.filled, // Filled button
    );
  }
}
