import 'package:flutter/material.dart';

class MessagesTopPanel extends StatelessWidget {
  const MessagesTopPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 26,
        left: 26,
        right: 26,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 277,
            height: 44,
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Пошук повідомлень',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color.fromARGB(255, 241, 241, 241),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 220, 219, 219),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              ),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.archive_outlined,
              color: Colors.black,
            ),
            label: const Text('Архів'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 241, 241, 241),
              side: const BorderSide(
                color: Color.fromARGB(255, 220, 219, 219),
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              minimumSize: const Size(98, 50),
            ),
          ),
        ],
      ),
    );
  }
}
