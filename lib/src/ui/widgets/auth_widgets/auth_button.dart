import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color disabledColor;
  final bool? isButtonDisabled;

  const AuthButton({
    super.key,
    required this.text,
    this.onPressed,
    this.disabledColor = const Color(0xFFFFCC85),
    this.isButtonDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 354),
      child: ElevatedButton(
        onPressed: isButtonDisabled == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonDisabled == true
              ? AppTheme.disabledButtonColor
              : AppTheme.activeButtonColor,
          foregroundColor: AppTheme.witeText,
          minimumSize: const Size(354, 44),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBackgroundColor: AppTheme.disabledButtonColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: AppTheme.witeText,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
