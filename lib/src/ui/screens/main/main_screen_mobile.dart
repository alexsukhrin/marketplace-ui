import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/main_screen_widgets/mobile/categories.dart';
import 'package:flutter_application_1/src/ui/widgets/shared_widgets/searh_field.dart';
import '../../widgets/main_screen_widgets/mobile/footerBar.dart';
import '../../widgets/main_screen_widgets/mobile/main_appbar.dart';

class MainScreenMobile extends StatelessWidget {
  const MainScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchField(
                onSearch: () {
                  // Implement search logic
                  print("Search icon tapped!");
                },
              ),
              // CustomCarousel(),
              const CategoriesWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const FooterBarWidget(),
    );
  }
}
