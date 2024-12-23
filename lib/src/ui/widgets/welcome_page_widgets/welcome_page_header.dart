import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class WelcomePageHeader extends StatelessWidget implements PreferredSizeWidget {
  final String routeName;

  const WelcomePageHeader({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColorWhite,
        toolbarHeight: 80,
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, routeName);
              },
              child: const Text(
                'Пропустити',
                style: TextStyle(
                  color: AppTheme.lightBodyColor,
                  fontSize: 15,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
