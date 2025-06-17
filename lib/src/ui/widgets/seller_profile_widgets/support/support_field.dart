import 'package:flutter/material.dart';

class SupportField extends StatelessWidget {
  const SupportField(
      {super.key, required this.labelText, required this.enteredText});
  final String labelText;
  final TextEditingController enteredText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: enteredText,
          decoration: InputDecoration(
            hintText: 'Введіть тут',
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
          ),
        ),
      ],
    );
  }
}
