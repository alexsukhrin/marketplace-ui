import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../themes/app_theme.dart';
import 'dropdown.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: Logo, Categories Dropdown, and Titles
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo_desktop.png',
                width: 35,
                height: 44,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 24),

              // Dropdown for Categories
              const Padding(
                padding: EdgeInsets.only(top: 28),
                child: CategoryDropdown(),
              ),

              const SizedBox(width: 24),

              TextButton(
                onPressed: () {
                  // Handle "Сезонні пропозиції" click
                },
                child: const Text(
                  'Сезонні пропозиції',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              TextButton(
                onPressed: () {
                  // Handle "Рейтинг продавців" click
                },
                child: const Text(
                  'Рейтинг продавців',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          // Right: Action Buttons
          Row(
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/footer_icons/search.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  // Handle search action
                },
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/images/main_icons/cart_icon.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  // Handle search action
                },
              ),
              const SizedBox(width: 16),

              // Login Button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.linkTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Увійти'),
              ),
              const SizedBox(width: 8),

              // Download App Button
              OutlinedButton(
                onPressed: () {
                  // Handle app download action
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.linkTextColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Завантажити застосунок',
                  style: TextStyle(color: AppTheme.linkTextColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
