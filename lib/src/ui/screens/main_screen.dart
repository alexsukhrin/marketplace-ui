import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/main_screen_widgets/categories.dart';
import 'package:flutter_application_1/src/ui/widgets/main_screen_widgets/searh_field.dart';
import '../widgets/main_screen_widgets/carousel_widget.dart';
import '../widgets/main_screen_widgets/footerBar.dart';
import '../widgets/main_screen_widgets/main_appbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final slides = [
      {
        'title': 'Новинки',
        'subtitle': 'У спортивних товарах.',
        'image': 'assets/images/samples/sample1.png',
      },
      {
        'title': 'Популярне',
        'subtitle': 'Все для спорту.',
        'image': 'assets/images/samples/sample1.png'
      },
      {
        'title': 'Знижки',
        'subtitle': 'До -50%!',
        'image': 'assets/images/samples/sample1.png'
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchField(),
              CustomCarousel(slides: slides),
              CategoriesWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterBarWidget(),
    );
  }
}
