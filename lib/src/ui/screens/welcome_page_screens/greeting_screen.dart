import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/shared_widgets/custom_button.dart';
import '../../widgets/responsive/responsive_design.dart';
import '../../widgets/welcome_page_widgets/left_section.dart';
import '../../widgets/welcome_page_widgets/progress_indicator.dart';

class GreetingScreen extends StatelessWidget {
  const GreetingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TResponsiveWidget(
          desktop: Padding(
            padding: EdgeInsets.symmetric(vertical: 33.0, horizontal: 61.0),
            child: Desktop(),
          ),
          tablet: Tablet(),
          mobile: Mobile()),
    );
  }
}

class Desktop extends StatelessWidget {
  const Desktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const LeftSection(
              imagePath: 'assets/images/welcome_page/greeting_screen.svg'),

          // Right Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Info and Skip
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const InfoIcon(
                          tooltipText:
                              "This page contains important information."),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/main');
                        },
                        child: const Text(
                          'Пропустити',
                          style: TextStyle(
                            color: Color(0xFF8E8E8E),
                            fontSize: 15,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Main Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const GreetingText(
                          crossAxisAlignment: CrossAxisAlignment.center),
                      const SizedBox(height: 36),
                      CustomButton(
                        text: "Давай почнемо",
                        onPressed: () {
                          Navigator.pushNamed(context, '/chooseRole');
                        },
                        isButtonDisabled: false,
                        buttonType: ButtonType.filled, // Filled button
                      ),
                    ],
                  ),

                  const ProgressIndicatorRow(order: [
                    "active",
                    "space",
                    "inactive",
                    "space",
                    "inactive"
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Tablet extends StatelessWidget {
  const Tablet({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class Mobile extends StatelessWidget {
  const Mobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColorWhite,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Logo
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 30,
            ),
            // Skip Button
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/chooseRole');
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            // Greeting Text
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.90,
                child: const GreetingText()),

            // Full-Screen SVG
            Expanded(
              child: SvgPicture.asset(
                'assets/images/welcome_page/greeting_screen.svg',
                fit: BoxFit.contain,
              ),
            ),

            // Progress Indicator
            const ProgressIndicatorRow(
                order: ["active", "space", "inactive", "space", "inactive"]),

            const SizedBox(height: 12),
            // Button
            CustomButton(
              text: "Давай почнемо",
              onPressed: () {
                Navigator.pushNamed(context, '/chooseRole');
              },
              isButtonDisabled: false,
              buttonType: ButtonType.filled, // Filled button
            ),

            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

class InfoIcon extends StatefulWidget {
  final String tooltipText;

  const InfoIcon({super.key, required this.tooltipText});

  @override
  _InfoIconState createState() => _InfoIconState();
}

class _InfoIconState extends State<InfoIcon> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Tooltip(
        message: widget.tooltipText,
        textStyle: const TextStyle(color: Colors.black),
        decoration: BoxDecoration(
          color: AppTheme.progressIndicatorActive,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Icon(
            Icons.info_outline,
            size: 24,
            color: isHovered ? AppTheme.linkTextColor : AppTheme.lightBodyColor,
          ),
        ),
      ),
    );
  }
}

class GreetingText extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  const GreetingText({
    super.key,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: const [
        Text(
          "Привіт!",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          "Дякуємо, що обрали наш застосунок!",
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.lightBodyColor,
          ),
        ),
        SizedBox(height: 4),
        Text(
          "Давай спершу познайомимось?",
          style: TextStyle(
            fontSize: 16,
            color: AppTheme.lightBodyColor,
          ),
        ),
      ],
    );
  }
}
