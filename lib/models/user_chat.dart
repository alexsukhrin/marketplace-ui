import 'package:flutter_application_1/models/chat_message.dart';

class UserChat {
  final String id;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final String status;
  final bool isOnline;
  final int unreadCount;
  final List<ChatMessage> messages;
  final DateTime lastSeen;

  UserChat({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.status,
    required this.isOnline,
    required this.unreadCount,
    required this.lastSeen,
    required this.messages,
  });
}
