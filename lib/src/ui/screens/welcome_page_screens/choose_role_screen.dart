import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/services/user_role_service.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/auth_widgets/auth_button.dart';

import '../../widgets/welcome_page_widgets/custom_outlined_button.dart';

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
      'is-seller': selectedRole == 'seller',
      'is-buyer': selectedRole == 'customer',
    };
    try {
      // Send the selected role using UserRoleService
      await UserRoleService.sendRole(roleMap);

      // Navigate to the next screen
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
      appBar: const WelcomePageHeader(
        routeName: '/selectCategory',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomOutlinedButton(
                  text: "Покупцем",
                  onPressed: () {
                    setState(() {
                      selectedRole = 'customer';
                    });
                  },
                  isSelected: selectedRole == 'customer',
                ),
                const SizedBox(width: 20),
                CustomOutlinedButton(
                  text: "Продавцем",
                  onPressed: () {
                    setState(() {
                      selectedRole = 'seller';
                    });
                  },
                  isSelected: selectedRole == 'seller',
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SvgPicture.asset(
                'assets/images/welcome_page/choose_role_screen.svg',
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 6,
                  width: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFB6B6B6),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  height: 6,
                  width: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEFEFEF),
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  AuthButton(
                    text: "Далі",
                    onPressed: selectedRole == null ? null : submitRole,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 45),
          ],
        ),
      ),
    );
  }
}
