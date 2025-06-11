import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/screens/main/sidebar_screens/listing_page.dart';
import 'package:flutter_application_1/src/ui/screens/notFoundScreen/pageNotFoundScreen.dart';
import 'package:flutter_application_1/src/ui/screens/productDetailsScreen/product_details_screen.dart';
import 'package:flutter_application_1/src/ui/screens/seller_profile/seller_profile_screen.dart';
import 'package:flutter_application_1/src/ui/widgets/bread_crumb_navigation.dart';
import 'package:flutter_application_1/src/ui/widgets/shared_widgets/page_navigation_header.dart';
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

class MainScreenDesktop extends StatefulWidget {
  const MainScreenDesktop({super.key});

  @override
  State<MainScreenDesktop> createState() => _MainScreenDesktopState();
}

class _MainScreenDesktopState extends State<MainScreenDesktop> {
  String _selectedPage = 'home';
  Map<String, dynamic>? _selectedProduct;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onMenuItemSelected(String page) {
    setState(() {
      _selectedPage = page;
    });
  }

  void _openProductDetails(Map<String, dynamic> product) {
    setState(() {
      _selectedProduct = product;
      _selectedPage = 'productDetails';
    });
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _getSelectedPageContent() {
    switch (_selectedPage) {
      // case 'search':d
      //   return const SearchPage();
      case 'favorites':
        return const FavoritesScreen();
      case 'cart':
        return const CartScreen();
      case 'chat':
        return const ChatScreen();
      case 'sell':
        return const ListingPage();
      case 'notifications':
        return const NotificationsScreen();
      case 'delivery':
        return const DeliveryScreen();
      case 'about':
        return const AboutScreen();
      case 'productDetails':
        if (_selectedProduct != null) {
          return ProductDetailsScreen(product: _selectedProduct!);
        } else {
          return const PageNotFoundScreen();
        }
      case 'sellerProfile':
        return const SellerProfileScreen();
      default:
        return Column(
          children: [
            const CategoryWidget(),
            const SizedBox(height: 60),
            SeasonalOffersWidget(),
            const SizedBox(height: 60),
            NewOffersWidget(onProductTap: _openProductDetails),
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
                      AppBarWidget(onMenuItemSelected: _onMenuItemSelected),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 55,
                              right: 55,
                              bottom: _selectedPage == 'sellerProfile' ? 0 : 50,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_selectedPage == 'productDetails')
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                        bottom: 24),
                                    child: BreadcrumbNavigation(
                                      items: [
                                        BreadcrumbItem(
                                          label: 'Головна',
                                          onTap: () =>
                                              _onMenuItemSelected('home'),
                                        ),
                                        // BreadcrumbItem(
                                        //   label: 'Взуття',
                                        //   onTap: () => _onMenuItemSelected(
                                        //       'categoryShoes'),
                                        // ),
                                        BreadcrumbItem(
                                          label:
                                              _selectedProduct?['title'] ?? '',
                                        ),
                                      ],
                                    ),
                                  ),
                                PageHeader(
                                  currentPage: _selectedPage,
                                  onMenuItemSelected: _onMenuItemSelected,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                _getSelectedPageContent(),
                                if (_selectedPage != 'sellerProfile') ...[
                                  const SizedBox(height: 80),
                                  FooterSection(),
                                ],
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
