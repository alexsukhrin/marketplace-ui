import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/mock_data.dart';
import 'package:flutter_application_1/models/user_chat.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/chat_panel_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/empty_account_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/messages_list_panel_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/messages_top_panel_widget.dart';

class MessagesWidget extends StatefulWidget {
  const MessagesWidget({super.key});

  @override
  State<MessagesWidget> createState() => _MessagesWidgetState();
}

class _MessagesWidgetState extends State<MessagesWidget> {
  UserChat? selectedUser;

  void _onUserSelected(UserChat user) {
    setState(() {
      selectedUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    final activeChats =
        userChats.where((chat) => chat.status == 'active').toList();
    final requestChats =
        userChats.where((chat) => chat.status == 'request').toList();
    final inactiveChats =
        userChats.where((chat) => chat.status == 'inactive').toList();

    final bool noChats =
        activeChats.isEmpty && requestChats.isEmpty && inactiveChats.isEmpty;

    return Container(
      height: MediaQuery.of(context).size.height * 0.855,
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
              bottomLeft: const Radius.circular(16),
              bottomRight: noChats ? const Radius.circular(16) : Radius.zero,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const MessagesTopPanel(),
              const SizedBox(height: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: MessagesListPanel(
                        activeUsers: activeChats,
                        requestUsers: requestChats,
                        inactiveUsers: inactiveChats,
                        onUserSelected: _onUserSelected,
                        selectedUser: selectedUser,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      flex: 2,
                      child: selectedUser != null
                          ? selectedUser!.messages.isNotEmpty
                              ? ChatPanel(userChat: selectedUser!)
                              : const Center(
                                  child: Text('Немає повідомлень'),
                                )
                          : activeChats.isEmpty &&
                                  requestChats.isEmpty &&
                                  inactiveChats.isEmpty
                              ? const Center(
                                  child: EmptyAccountWidget(
                                    text: 'У вас ще немає повідомлень',
                                    subtext:
                                        'Повідомлення з’явиться тут після того \nяк покупець напише вам.',
                                  ),
                                )
                              : Container(
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFF7F7F7),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: const Center(
                                    child:
                                        Text('Оберіть чат зі списку ліворуч'),
                                  ),
                                ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
