import 'package:flutter/material.dart';

class SupportDescriptionField extends StatelessWidget {
  const SupportDescriptionField(
      {super.key, required this.labelText, required this.enteredText});
  final String labelText;
  final TextEditingController enteredText;

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextFormField(
          controller: enteredText,
          maxLines: 6,
          decoration: InputDecoration(
            hintText: 'Введіть тут',
            filled: true,
            fillColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
