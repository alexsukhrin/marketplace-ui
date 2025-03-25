import 'package:flutter/material.dart';
import '../../widgets/main_screen_widgets/desktop/appbar_desktop.dart';
import '../../widgets/main_screen_widgets/desktop/categories_list.dart';
import '../../widgets/main_screen_widgets/desktop/feature_cards.dart';
import '../../widgets/main_screen_widgets/desktop/footer_desktop.dart';
import '../../widgets/main_screen_widgets/desktop/fqa_section.dart';
import '../../widgets/main_screen_widgets/desktop/marquee_banner.dart';
import '../../widgets/main_screen_widgets/desktop/new_offers.dart';
import '../../widgets/main_screen_widgets/desktop/season_of_offers.dart';
import '../../widgets/main_screen_widgets/desktop/sidebar_desktop.dart';

class MainScreenDesktop extends StatelessWidget {
  const MainScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Display the banner at the top
          MarqueeBanner(),

          Expanded(
            child: Row(
              children: [
                // Sidebar on the left
                const SidebarWidget(),

                // Main Content Area
                Expanded(
                  child: Column(
                    children: [
                      // AppBar at the top
                      const AppBarWidget(),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 55, right: 55, bottom: 50),
                            child: Column(
                              children: [
                                const CategoryWidget(),
                                const SizedBox(height: 60),
                                SeasonalOffersWidget(),
                                const SizedBox(height: 60),
                                NewOffersWidget(),
                                const SizedBox(height: 40),
                                FeaturesSection(),
                                const SizedBox(height: 80),
                                FAQSection(),
                                const SizedBox(height: 80),
                                FooterSection(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
