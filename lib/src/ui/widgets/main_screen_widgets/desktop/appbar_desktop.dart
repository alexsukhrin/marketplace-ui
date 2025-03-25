import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'appbar_buttons.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 55.0),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo_desktop.png',
                    width: 35,
                    height: 44,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(width: 30),

                  // // Dropdown for Categories
                  // const Padding(
                  //   padding: EdgeInsets.only(top: 28),
                  //   child: CategoryDropdown(),
                  // ),

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
                  const SizedBox(width: 20),
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
            ],
          ),
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
              const MainAuthButtons(),
            ],
          ),
        ],
      ),
    );
  }
}
