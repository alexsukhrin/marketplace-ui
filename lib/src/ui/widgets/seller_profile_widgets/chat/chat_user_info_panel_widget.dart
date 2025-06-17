import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/user_chat.dart';

class ChatUserInfoPanel extends StatelessWidget {
  final UserChat user;
  final bool isVisible;
  final VoidCallback onClose;

  const ChatUserInfoPanel({
    super.key,
    required this.user,
    required this.isVisible,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      right: isVisible ? 0 : -MediaQuery.of(context).size.width * 0.5,
      top: 0,
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: onClose,
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(user.avatarUrl),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Column(
                  children: [
                    Text(
                      "${user.firstName} ${user.lastName}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      user.isOnline
                          ? "Онлайн"
                          : "Останній вхід: ${user.lastSeen}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildColorBlock(color: const Color(0xFFF3F3F3)),
                  _buildColorBlock(color: const Color(0xFFF2EFFF)),
                  _buildColorBlock(color: const Color(0xFFEAFBF9)),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'Інформація',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'Дата: 12.03.2024',
                style: TextStyle(color: Colors.black87),
              ),
              const SizedBox(height: 24),
              const Text(
                'Контакти',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.phone, color: Colors.grey),
                  SizedBox(width: 12),
                  Text('+38 (096) 123 45 67'),
                ],
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  Icon(Icons.email, color: Colors.grey),
                  SizedBox(width: 12),
                  Text('example@email.com'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColorBlock({required Color color}) {
    return Container(
      width: 106,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
