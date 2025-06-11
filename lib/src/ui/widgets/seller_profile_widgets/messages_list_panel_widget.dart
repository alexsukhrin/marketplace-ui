import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_chat.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/message_tile.dart';

class MessagesListPanel extends StatelessWidget {
  final List<UserChat> activeUsers;
  final List<UserChat> requestUsers;
  final List<UserChat> inactiveUsers;
  final Function(UserChat) onUserSelected;
  final UserChat? selectedUser;

  const MessagesListPanel({
    super.key,
    required this.activeUsers,
    required this.requestUsers,
    required this.inactiveUsers,
    required this.onUserSelected,
    required this.selectedUser,
  });

  Widget buildSection(String title, List<UserChat> users, String emptyText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 21),
        if (users.isEmpty)
          Center(
            child: Text(emptyText, style: const TextStyle(color: Colors.grey)),
          )
        else
          ...users.map((userChat) => MessageTile(
                userChat: userChat,
                onUserSelected: onUserSelected,
                isSelected: selectedUser?.id == userChat.id,
              )),
        const SizedBox(height: 35),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSection("Активні", activeUsers, "Немає активних"),
                        buildSection("Запити", requestUsers, "Немає запитів"),
                        buildSection("Неактивні", inactiveUsers,
                            "Немає неактивних повідомлень"),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
