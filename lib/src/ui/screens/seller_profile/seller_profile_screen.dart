import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/account_data_menu.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/empty_account_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/messages_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/seller_sidebar_widget.dart';

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
        return const Center(child: Text("Сторінка 'Акаунт'"));
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
      case "help":
        return const Center(child: Text("Сторінка 'Допомога'"));
      case "settings":
        return const Center(child: Text('Сторінка налаштувань'));
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ви вибрали: ${selectedMenuItem.title}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 16),
              Text(
                'У вас ще немає ${selectedMenuItem.title.toLowerCase()}',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SellerSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            menuItems: accountMenuItems,
          ),
          const SizedBox(width: 56),
          Expanded(
            child: Center(child: _getSelectedPage(selectedIndex)),
          ),
        ],
      ),
    );
  }
}
