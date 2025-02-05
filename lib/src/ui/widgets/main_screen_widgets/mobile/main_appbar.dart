import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColorWhite,
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/logo.svg',
            height: 28,
            width: 28,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border),
          onPressed: () {},
          visualDensity: VisualDensity.compact,
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
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
