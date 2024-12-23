import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../themes/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColorWhite,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the logo
        children: [
          SvgPicture.asset(
            'assets/images/logo.svg', // Use SvgPicture.asset for SVG files
            height: 28,
            width: 28,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
