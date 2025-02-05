import 'package:flutter/material.dart';
import '../../widgets/responsive/responsive_design.dart';
import 'main_screen_mobile.dart';
import 'main_screen_desktop.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TResponsiveWidget(
      desktop: MainScreenDesktop(),
      tablet: MainScreenDesktop(),
      mobile: MainScreenMobile(),
    );
  }
}
