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
import 'sidebar_screens/about.dart';
import 'sidebar_screens/cart.dart';
import 'sidebar_screens/chat.dart';
import 'sidebar_screens/delivery.dart';
import 'sidebar_screens/favotites.dart';
import 'sidebar_screens/notifications.dart';
import 'sidebar_screens/sell.dart';

class MainScreenDesktop extends StatefulWidget {
  const MainScreenDesktop({super.key});

  @override
  State<MainScreenDesktop> createState() => _MainScreenDesktopState();
}

class _MainScreenDesktopState extends State<MainScreenDesktop> {
  String _selectedPage = 'home';

  void _onMenuItemSelected(String page) {
    setState(() {
      _selectedPage = page;
    });
  }

  Widget _getSelectedPageContent() {
    switch (_selectedPage) {
      // case 'search':
      //   return const SearchPage();
      case 'favorites':
        return const FavoritesScreen();
      case 'cart':
        return const CartScreen();
      case 'chat':
        return const ChatScreen();
      case 'sell':
        return const SellScreen();
      case 'notifications':
        return const NotificationsScreen();
      case 'delivery':
        return const DeliveryScreen();
      case 'about':
        return const AboutScreen();
      default:
        return Column(
          children: [
            const CategoryWidget(),
            const SizedBox(height: 60),
            SeasonalOffersWidget(),
            const SizedBox(height: 60),
            const NewOffersWidget(),
            const SizedBox(height: 40),
            FeaturesSection(),
            const SizedBox(height: 80),
            FAQSection(),
            // const SizedBox(height: 80),
            // FooterSection(),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MarqueeBanner(),
          Expanded(
            child: Row(
              children: [
                SidebarWidget(onMenuItemSelected: _onMenuItemSelected),
                Expanded(
                  child: Column(
                    children: [
                      const AppBarWidget(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 55, right: 55, bottom: 50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _getSelectedPageContent(),
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
