import 'package:flutter/material.dart';

class SellerSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const SellerSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 198,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildItem("Акаунт", 0, Icons.person_outline_rounded),
                _buildItem("Повідомлення", 1, Icons.message),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 198,
                    height: 30,
                    child: Divider(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                _buildItem("Оголошення", 2, Icons.shopping_bag_outlined),
                _buildItem("На модерації", 3, Icons.remove_red_eye_outlined),
                _buildItem("Відхилені", 4, Icons.delete_forever_outlined),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 198,
                    height: 30,
                    child: Divider(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                _buildItem("Аналітика", 5, Icons.analytics_outlined),
                _buildItem("Кошти", 6, Icons.credit_card_outlined),
                _buildItem("Повернення", 7, Icons.assignment_return_outlined),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 198,
                    height: 30,
                    child: Divider(
                      color: Colors.grey.shade200,
                    ),
                  ),
                ),
                _buildItem("Допомога", 8, Icons.live_help_outlined),
                _buildItem("Налаштування", 9, Icons.settings),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String title, int index, IconData icon) {
    final isSelected = selectedIndex == index;

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.black,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
        onTap: () => onItemSelected(index),
      ),
    );
  }
}
