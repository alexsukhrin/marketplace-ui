import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/messages_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/seller_sidebar_widget.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  int selectedIndex = 0;

  final List<String> sections = [
    "Акаунт",
    "Повідомлення",
    "Оголошення",
    "На модерації",
    "Відхилені",
    "Аналітика",
    "Кошти",
    "Повернення",
    "Допомога",
    "Налаштування"
  ];
  Widget _getSelectedPage(int index) {
    switch (index) {
      case 1:
        return const MessagesWidget();
      default:
        return Column(
          children: [
            Text(
              'Ви вибрали: ${sections[index]}',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SellerSidebar(
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
          const SizedBox(width: 56),
          Expanded(
            child: _getSelectedPage(selectedIndex),
          ),
        ],
      ),
    );
  }
}
