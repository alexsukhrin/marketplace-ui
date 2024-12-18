import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  const CustomOutlinedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 11,
        ),
        backgroundColor:
            isSelected ? AppTheme.activeButtonColor : Colors.transparent,
        side: const BorderSide(color: AppTheme.activeButtonColor),
        foregroundColor:
            isSelected ? Colors.transparent : AppTheme.activeButtonColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppTheme.witeText : AppTheme.activeButtonColor,
        ),
      ),
    );
  }
}
