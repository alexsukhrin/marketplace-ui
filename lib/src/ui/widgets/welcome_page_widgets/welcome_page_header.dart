import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class WelcomePageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String routeName;
  final double toolbarHeight;

  const WelcomePageHeader({
    super.key,
    required this.routeName,
    this.toolbarHeight = 80,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColorWhite,
      toolbarHeight: toolbarHeight,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.lightBodyColor),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/main');
            },
            child: const Text(
              'Пропустити це питання',
              style: TextStyle(
                color: AppTheme.lightBodyColor,
                fontSize: 15,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
