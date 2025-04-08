import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/services/user_role_service.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/app_theme.dart';
import '../../widgets/shared_widgets/custom_button.dart';
import '../../widgets/responsive/responsive_design.dart';
import '../../widgets/welcome_page_widgets/custom_outlined_button.dart';
import '../../widgets/welcome_page_widgets/left_section.dart';
import '../../widgets/welcome_page_widgets/progress_indicator.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});

  @override
  ChooseRoleScreenState createState() => ChooseRoleScreenState();
}

class ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String? selectedRole;

  Future<void> submitRole() async {
    if (selectedRole == null) return;
    final roleMap = {
      'is_seller': selectedRole == 'seller',
      'is_buyer': selectedRole == 'customer',
    };
    try {
      await UserRoleService.sendRole(roleMap);

      Navigator.pushNamed(context, '/selectCategory');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit role: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TResponsiveWidget(
          desktop: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 33.0, horizontal: 61.0),
            child: Desktop(
              selectedRole: selectedRole,
              onRoleSelected: (role) {
                setState(() {
                  selectedRole = role;
                });
              },
              onSubmitRole: submitRole,
            ),
          ),
          tablet: const Tablet(),
          mobile: Mobile(
            selectedRole: selectedRole,
            onRoleSelected: (role) {
              setState(() {
                selectedRole = role;
              });
            },
            onSubmitRole: submitRole,
          )),
    );
  }
}

class RoleSelectionWidget extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;

  const RoleSelectionWidget({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        // const SizedBox(height: 10),
        const Text(
          "Обирай ким ти є?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "Це можна змінити у любий момент.",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 36),
        Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            CustomOutlinedButton(
              text: "Покупцем",
              onPressed: () => onRoleSelected('customer'),
              isSelected: selectedRole == 'customer',
            ),
            const SizedBox(width: 20),
            CustomOutlinedButton(
              text: "Продавцем",
              onPressed: () => onRoleSelected('seller'),
              isSelected: selectedRole == 'seller',
            ),
          ],
        ),
        // const SizedBox(height: 24),
      ],
    );
  }
}

class Desktop extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;
  final Future<void> Function() onSubmitRole;

  const Desktop({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
    required this.onSubmitRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const LeftSection(
              imagePath: 'assets/images/welcome_page/choose_role_screen.svg'),

          // Right Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip
                  AppBar(
                    backgroundColor: AppTheme.backgroundColorWhite,
                    toolbarHeight: 28,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppTheme.lightBodyColor),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),

                  // Main Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoleSelectionWidget(
                        selectedRole: selectedRole,
                        onRoleSelected: onRoleSelected,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      const SizedBox(height: 36),
                      SubmitRoleButton(
                        selectedRole: selectedRole,
                        onSubmitRole: onSubmitRole,
                      ),
                    ],
                  ),

                  const ProgressIndicatorRow(order: [
                    "inactive",
                    "space",
                    "active",
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
    // implement build
    throw UnimplementedError();
  }
}

class Mobile extends StatelessWidget {
  final String? selectedRole;
  final ValueChanged<String> onRoleSelected;
  final Future<void> Function() onSubmitRole;

  const Mobile({
    super.key,
    required this.selectedRole,
    required this.onRoleSelected,
    required this.onSubmitRole,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WelcomePageHeader(
        routeName: '/selectCategory',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            RoleSelectionWidget(
              selectedRole: selectedRole,
              onRoleSelected: onRoleSelected,
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/welcome_page/choose_role_screen.svg',
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 18),
            const ProgressIndicatorRow(
                order: ["inactive", "space", "active", "space", "inactive"]),
            const SizedBox(height: 12),
            Center(
              child: SubmitRoleButton(
                selectedRole: selectedRole,
                onSubmitRole: onSubmitRole,
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}

class SubmitRoleButton extends StatelessWidget {
  final String? selectedRole;
  final Future<void> Function() onSubmitRole;

  const SubmitRoleButton({
    super.key,
    required this.selectedRole,
    required this.onSubmitRole,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: "Далі",
      onPressed: selectedRole == null
          ? null
          : onSubmitRole, // Disable if no role selected
      isButtonDisabled:
          selectedRole == null, // Disable button if no role selected
      buttonType: ButtonType.filled,
    );
  }
}
