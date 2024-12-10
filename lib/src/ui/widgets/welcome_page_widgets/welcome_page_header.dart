import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class WelcomePageHeader extends StatelessWidget implements PreferredSizeWidget {
  const WelcomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                Navigator.pushNamed(context, '/selectCategory');
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
        // elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
