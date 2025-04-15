import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';

import '../../../services/categories_service.dart';
import '../../widgets/shared_widgets/custom_button.dart';
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

  void toggleCategory(Map<String, dynamic> category) {
    setState(() {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
    });
  }

  Future<void> submitCategories() async {
    try {
      await CategoryService.submitCategories(selectedCategories);

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
  final TextAlign textAlign;
  final WrapAlignment wrapAlignment;

  const CategorySelectionWidget({
    super.key,
    required this.categories,
    required this.selectedCategories,
    required this.toggleCategory,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign = TextAlign.start,
    this.wrapAlignment = WrapAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          "Яким категоріям надаєш\nперевагу?",
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Твої відповіді допоможуть нам підібрати\nнайкращі пропозиції для тебе.",
          textAlign: textAlign,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          alignment: wrapAlignment,
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
                    toolbarHeight: 28,
                  ),

                  // Main Content
                  SizedBox(
                    width: 440,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CategorySelectionWidget(
                          categories: categories,
                          selectedCategories: selectedCategories,
                          toggleCategory: toggleCategory,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          textAlign: TextAlign.center,
                          wrapAlignment: WrapAlignment.center,
                        ),
                        const SizedBox(height: 36),
                        SubmitCategoriesButton(
                          submitCategories: submitCategories,
                          isCategorySelected: selectedCategories.isNotEmpty,
                        )
                      ],
                    ),
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
    //implement build
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
                  SubmitCategoriesButton(
                    submitCategories: submitCategories,
                    isCategorySelected: selectedCategories.isNotEmpty,
                  ),
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
  final bool isCategorySelected;

  const SubmitCategoriesButton({
    super.key,
    required this.submitCategories,
    required this.isCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "На головну сторінку",
      onPressed: isCategorySelected ? submitCategories : null,
      buttonType: ButtonType.filled,
    );
  }
}
