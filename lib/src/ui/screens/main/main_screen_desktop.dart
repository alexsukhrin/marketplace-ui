import 'package:flutter/material.dart';
import '../../widgets/main_screen_widgets/desktop/appbar_desktop.dart';
import '../../widgets/main_screen_widgets/desktop/sidebar_desktop.dart';

class MainScreenDesktop extends StatelessWidget {
  const MainScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Row(
        children: [
          // Sidebar on the left
          SidebarWidget(),

          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // AppBar at the top
                AppBarWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
