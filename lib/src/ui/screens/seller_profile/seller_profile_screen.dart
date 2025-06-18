import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/account_data_menu.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/empty_account_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/messages_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/seller_sidebar_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/profile/profile_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/settings/account_settings_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/support/support_widget.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  int selectedIndex = 0;

  bool _hasData(String id) {
    switch (id) {
      case "announcements":
      case "moderation":
      case "rejected":
      case "analytics":
      case "wallets":
      case "return":
        return false;
      default:
        return true;
    }
  }

  Widget _getSelectedPage(int index) {
    final selectedMenuItem = accountMenuItems[index];
    if (!_hasData(selectedMenuItem.id)) {
      return EmptyAccountWidget(
        text: selectedMenuItem.text!,
        subtext: selectedMenuItem.subtext,
      );
    }

    switch (selectedMenuItem.id) {
      case "messages":
        return const MessagesWidget();
      case "account":
        return const ProfileWidget();
      case "announcements":
        return const Center(child: Text("Тут буде список оголошень"));
      case "moderation":
        return const Center(child: Text("Сторінка 'На модерації'"));
      case "rejected":
        return const Center(child: Text("Сторінка 'Відхилені'"));
      case "analytics":
        return const Center(child: Text("Сторінка 'Аналітика'"));
      case "wallets":
        return const Center(child: Text("Сторінка 'Кошти'"));
      case "returns":
        return const Center(child: Text("Сторінка 'Повернення'"));
      case "support":
        return const SupportWidget();
      case "settings":
        return const AccountSettingsWidget();
      default:
        return const Center(child: Text('Невідома сторінка'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 198,
          child: SellerSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            menuItems: accountMenuItems,
          ),
        ),
        const SizedBox(width: 56),
        Expanded(
          child: _getSelectedPage(selectedIndex),
        ),
      ],
    );
  }
}
