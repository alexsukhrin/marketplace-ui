import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/welcome_page_widgets/welcome_page_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/custom_button.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../widgets/welcome_page_widgets/custom_outlined_button.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({Key? key}) : super(key: key);

  @override
  _ChooseRoleScreenState createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String? selectedRole;

  Future<void> _submitRole() async {
    if (selectedRole == null) return;

    final url = Uri.parse('https://your-backend-api.com/role');
    final body = jsonEncode({'role': selectedRole});

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // Successfully sent data to backend
        print('Role submitted: $selectedRole');
        Navigator.pushNamed(context, '/selectCategory');
      } else {
        // Handle server error
        print('Error submitting role: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network error
      print('Network error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WelcomePageHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            CustomButton(
              text: "Далі",
              onPressed: selectedRole == null ? null : _submitRole,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
