import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/settings/account_switch_widget.dart';

class AccountSettingsWidget extends StatefulWidget {
  const AccountSettingsWidget({super.key});

  @override
  State<AccountSettingsWidget> createState() => _AccountSettingsWidgetState();
}

class _AccountSettingsWidgetState extends State<AccountSettingsWidget> {
  String selectedTheme = 'light';
  String selectedLanguage = 'ukr';
  bool _emailNotifications = true;
  bool _pushNotifications = false;

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Сповіщення',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        AccountSwitchWidget(
          label: 'Пошта',
          value: _emailNotifications,
          onChanged: (newValue) {
            setState(() {
              _emailNotifications = newValue;
            });
          },
        ),
        const SizedBox(height: 8),
        AccountSwitchWidget(
          label: 'Пуш-сповіщення',
          value: _pushNotifications,
          onChanged: (newValue) {
            setState(() {
              _pushNotifications = newValue;
            });
          },
        ),
        const SizedBox(height: 40),
        const Text(
          'Тема',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        AccountSwitchWidget(
          label: 'Світла',
          value: selectedTheme == 'light',
          onChanged: (newValue) {
            if (newValue) {
              setState(() {
                selectedTheme = 'light';
              });
            }
          },
        ),
        const SizedBox(height: 8),
        AccountSwitchWidget(
          label: 'Темна',
          value: selectedTheme == 'dark',
          onChanged: (newValue) {
            if (newValue) {
              setState(() {
                selectedTheme = 'dark';
              });
            }
          },
        ),
        const SizedBox(height: 40),
        const Text(
          'Мова',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        AccountSwitchWidget(
          label: 'Українська',
          value: selectedLanguage == 'ukr',
          onChanged: (newValue) {
            if (newValue) {
              setState(() {
                selectedLanguage = 'ukr';
              });
            }
          },
        ),
        const SizedBox(height: 8),
        AccountSwitchWidget(
          label: 'Англійська',
          value: selectedLanguage == 'en',
          onChanged: (newValue) {
            if (newValue) {
              setState(() {
                selectedLanguage = 'en';
              });
            }
          },
        ),
        const SizedBox(height: 40),
        const Text(
          'Акаунт',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(213, 40),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Видалити акаунт',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
          ),
        )
      ],
    );
  }
}
