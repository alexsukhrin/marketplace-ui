import 'package:flutter/material.dart';

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.labelText});
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 409,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labelText,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Введіть тут',
              filled: true,
              fillColor: Colors.grey.shade200,
              hoverColor: Colors.grey.shade200,
              focusColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 22, vertical: 20),
              suffixIcon: Icon(
                Icons.edit,
                color: Colors.grey.shade700,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
