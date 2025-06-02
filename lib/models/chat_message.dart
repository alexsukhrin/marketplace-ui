class ChatMessage {
  final String id;
  final String message;
  final DateTime time;
  final bool isRead;
  final bool isSentByMe;

  ChatMessage(
      {required this.id,
      required this.message,
      required this.time,
      required this.isRead,
      required this.isSentByMe});
}
