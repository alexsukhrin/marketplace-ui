import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class CharacterCounter extends StatelessWidget {
  final TextEditingController controller;
  final int? maxLength;
  final int? minLength;
  final bool showMinLength;

  const CharacterCounter({
    super.key,
    required this.controller,
    this.maxLength,
    this.minLength,
    this.showMinLength = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        final currentLength = value.text.length;

        String counterText = '';

        if (showMinLength && minLength != null) {
          counterText = '$minLength/$currentLength';
        } else if (maxLength != null) {
          counterText = '$currentLength/$maxLength';
        }

        return Align(
          alignment: Alignment.centerRight,
          child: Text(
            counterText,
            style: const TextStyle(
              fontSize: 15,
              color: AppTheme.textFieldCounterColor,
            ),
          ),
        );
      },
    );
  }
}
