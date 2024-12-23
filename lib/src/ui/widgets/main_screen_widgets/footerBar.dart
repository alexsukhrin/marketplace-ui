import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class FooterBarWidget extends StatefulWidget {
  const FooterBarWidget({super.key});

  @override
  FooterBarWidgetState createState() => FooterBarWidgetState();
}

class FooterBarWidgetState extends State<FooterBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildFooterItem(IconData icon, String label, int index) {
    bool isActive = _selectedIndex == index;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isActive)
            Container(
              margin: const EdgeInsets.only(bottom: 4.0),
              width: 20,
              height: 2,
              color: AppTheme.activeButtonColor,
            ),
          Icon(
            icon,
            size: 24,
            color: isActive
                ? AppTheme.activeButtonColor
                : AppTheme.progressIndicatorActive,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive
                  ? AppTheme.activeButtonColor
                  : AppTheme.progressIndicatorActive,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: BottomAppBar(
        color: AppTheme.backgroundColorWhite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildFooterItem(Icons.home_outlined, 'Головна', 0),
            _buildFooterItem(Icons.search_outlined, 'Пошук', 1),
            _buildFooterItem(Icons.add_box_outlined, 'Продати', 2),
            _buildFooterItem(Icons.chat_bubble_outline, 'Чат', 3),
            _buildFooterItem(Icons.account_circle_outlined, 'Акаунт', 4),
          ],
        ),
      ),
    );
  }
}
