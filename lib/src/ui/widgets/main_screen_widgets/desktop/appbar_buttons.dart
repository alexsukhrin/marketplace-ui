import 'package:flutter/material.dart';
import '../../../../utils/auth_validator.dart';
import '../../../themes/app_theme.dart';

class MainAuthButtons extends StatelessWidget {
  const MainAuthButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return TokenBasedWidget(
      child: Row(
        children: [
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
          OutlinedButton(
            onPressed: () {},
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
    );
  }
}
