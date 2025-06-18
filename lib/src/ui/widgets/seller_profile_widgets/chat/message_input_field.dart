import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onSend;

  const MessageInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      width: 676,
      height: 62,
      padding: const EdgeInsets.only(
        left: 13,
        right: 13,
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions_outlined),
            color: const Color(0xFF7C7C7C),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Напишіть повідомлення...',
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () {},
              iconSize: 22,
              color: const Color(0xFF7C7C7C)),
          Container(
            width: 1,
            height: 23,
            color: const Color(0xFFF2F2F2),
          ),
          IconButton(
            icon: Transform.translate(
              offset: const Offset(0, -3),
              child: Transform.rotate(
                angle: -0.9,
                child: const Icon(
                  Icons.send,
                  color: Color(0xFFFF9500),
                ),
              ),
            ),
            onPressed: onSend,
            iconSize: 22,
          ),
        ],
      ),
    );
  }
}
