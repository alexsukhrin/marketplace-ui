import 'package:flutter/material.dart';

class ReusableTextWidget extends StatelessWidget {
  final String mainText;
  final String? secondaryText;

  const ReusableTextWidget({
    super.key,
    required this.mainText,
    this.secondaryText,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            mainText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (secondaryText != null) ...[
            const SizedBox(height: 4),
            Text(
              secondaryText!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ]
        ],
      ),
    );
  }
}
