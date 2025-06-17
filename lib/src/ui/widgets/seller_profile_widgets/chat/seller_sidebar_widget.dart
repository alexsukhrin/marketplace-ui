import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/account_menu.dart';

class SellerSidebar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final List<AccountMenu> menuItems;

  const SellerSidebar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final item = menuItems[index];

              List<Widget> widgets = [];
              widgets.add(
                _buildItem(
                  title: item.title,
                  index: index,
                  iconPath: item.icon,
                  context: context,
                ),
              );
              if (item.id == "messages" ||
                  item.id == "rejected" ||
                  item.id == "return") {
                widgets.add(
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
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem({
    required String title,
    required int index,
    required String iconPath,
    required BuildContext context,
  }) {
    final isSelected = selectedIndex == index;
    final Widget iconWidget = Image.asset(
      iconPath,
      width: 22,
      height: 22,
      color: isSelected ? Colors.white : Colors.black,
    );

    return Container(
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: iconWidget,
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
