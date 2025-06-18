import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_chat.dart';
import 'package:flutter_application_1/models/chat_message.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/chat_user_info_panel_widget.dart';
import 'package:flutter_application_1/src/ui/widgets/seller_profile_widgets/chat/message_input_field.dart';

class ChatPanel extends StatefulWidget {
  final UserChat userChat;

  const ChatPanel({super.key, required this.userChat});

  @override
  State<ChatPanel> createState() => _ChatPanelState();
}

class _ChatPanelState extends State<ChatPanel> {
  final TextEditingController _controller = TextEditingController();
  bool _isUserInfoVisible = false;

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        final id = 'message_${widget.userChat.messages.length + 1}';
        widget.userChat.messages.add(
          ChatMessage(
            id: id,
            message: _controller.text,
            time: DateTime.now(),
            isRead: false,
            isSentByMe: true,
          ),
        );
        _controller.clear();
      });
    }
  }

  void _toggleUserInfoPanel() {
    setState(() {
      _isUserInfoVisible = !_isUserInfoVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.userChat;

    return Stack(children: [
      ClipRect(
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF7F7F7),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 28,
                    right: 31,
                    top: 14,
                    bottom: 8,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: _toggleUserInfoPanel,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user.avatarUrl),
                            ),
                            const SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user.firstName} ${user.lastName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  user.isOnline
                                      ? "Онлайн"
                                      : "Останній вхід: ${user.lastSeen}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.white),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      right: 16,
                      top: 12,
                      bottom: 24,
                    ),
                    child: ListView.builder(
                      itemCount: user.messages.length,
                      itemBuilder: (context, index) {
                        final message = user.messages[index];
                        final isUserMessage = message.isSentByMe;

                        final currentTime = DateTime.now();
                        final messageTime = message.time;
                        final diffInMinutes =
                            currentTime.difference(messageTime).inMinutes;

                        String timeText = '';
                        if (diffInMinutes > 1) {
                          timeText =
                              '${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}';
                        }

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Align(
                            alignment: isUserMessage
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: isUserMessage
                                        ? const Color(0xFF949494)
                                        : Colors.orange,
                                    borderRadius: BorderRadius.only(
                                      topRight: isUserMessage
                                          ? Radius.zero
                                          : const Radius.circular(16),
                                      topLeft: isUserMessage
                                          ? const Radius.circular(16)
                                          : Radius.zero,
                                      bottomRight: const Radius.circular(16),
                                      bottomLeft: const Radius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    message.message,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                if (timeText.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Text(
                                      timeText,
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 19),
                  child: MessageInputField(
                    controller: _controller,
                    onSend: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
          if (_isUserInfoVisible)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  color: Colors.black.withOpacity(0.02),
                ),
              ),
            ),
          ChatUserInfoPanel(
            user: widget.userChat,
            isVisible: _isUserInfoVisible,
            onClose: _toggleUserInfoPanel,
          ),
        ]),
      ),
    ]);
  }
}
