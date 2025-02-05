import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../themes/app_theme.dart';

class FooterBarWidget extends StatefulWidget {
  const FooterBarWidget({super.key});

  @override
  FooterBarWidgetState createState() => FooterBarWidgetState();
}

class FooterBarWidgetState extends State<FooterBarWidget> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.backgroundColorWhite,
        border: Border(
          top: BorderSide(color: AppTheme.progressIndicatorInactive),
        ),
      ),
      child: Stack(
        children: [
          BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppTheme.backgroundColorWhite,
            onTap: _navigateBottomBar,
            selectedItemColor: AppTheme.activeButtonColor,
            unselectedItemColor: AppTheme.progressIndicatorActive,
            selectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            items: [
              BottomNavigationBarItem(
                icon: _buildIcon('assets/images/footer_icons/home.svg', 0),
                label: 'Головна',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/images/footer_icons/search.svg', 1),
                label: 'Пошук',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/images/footer_icons/add.svg', 2),
                label: 'Продати',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/images/footer_icons/message.svg', 3),
                label: 'Чат',
              ),
              BottomNavigationBarItem(
                icon: _buildIcon('assets/images/footer_icons/profile.svg', 4),
                label: 'Акаунт',
              ),
            ],
          ),
          AnimatedPositioned(
            top: 0,
            left: _getLinePosition(),
            duration: const Duration(milliseconds: 200),
            child: _buildDash(),
          ),
        ],
      ),
    );
  }

  Widget _buildDash() {
    return Container(
      width: 25,
      height: 2,
      color: AppTheme.activeButtonColor,
    );
  }

  double _getLinePosition() {
    double screenWidth = MediaQuery.of(context).size.width;
    switch (_selectedIndex) {
      case 0:
        return screenWidth * 0.075;
      case 1:
        return screenWidth * 0.275;
      case 2:
        return screenWidth * 0.475;
      case 3:
        return screenWidth * 0.675;
      case 4:
        return screenWidth * 0.875;
      default:
        return 0.0;
    }
  }

  Widget _buildIcon(String assetPath, int index) {
    bool isSelected = _selectedIndex == index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          assetPath,
          colorFilter: ColorFilter.mode(
            isSelected
                ? AppTheme.activeButtonColor
                : AppTheme.progressIndicatorActive,
            BlendMode.srcIn,
          ),
          width: 24,
          height: 24,
        ),
        const SizedBox(height: 4),
      ],
    );
  }
}
