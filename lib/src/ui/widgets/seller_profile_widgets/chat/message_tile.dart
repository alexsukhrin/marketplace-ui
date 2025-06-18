import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_chat.dart';

class MessageTile extends StatelessWidget {
  final UserChat userChat;
  final Function(UserChat) onUserSelected;
  final bool isSelected;

  const MessageTile({
    super.key,
    required this.userChat,
    required this.onUserSelected,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final lastMessage =
        userChat.messages.isNotEmpty ? userChat.messages.last : null;

    return GestureDetector(
      onTap: () => onUserSelected(userChat),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? const Color(0xFFF7F7F7) : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 11,
            horizontal: 11,
          ),
          child: Row(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(userChat.avatarUrl),
                  ),
                  if (userChat.isOnline)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${userChat.firstName} ${userChat.lastName}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          lastMessage?.time != null
                              ? '${lastMessage?.time.hour.toString().padLeft(2, '0')}:${lastMessage?.time.minute.toString().padLeft(2, '0')}'
                              : '',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            lastMessage != null
                                ? (lastMessage.message.length > 20
                                    ? '${lastMessage.message.substring(0, 20)}...'
                                    : lastMessage.message)
                                : '',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        if (userChat.unreadCount > 0)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${userChat.unreadCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
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
