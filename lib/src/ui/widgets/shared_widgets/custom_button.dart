import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

enum ButtonType { filled, outlined }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color disabledColor;
  final bool? isButtonDisabled;
  final ButtonType buttonType;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.disabledColor = const Color(0xFFFFCC85),
    this.isButtonDisabled,
    this.buttonType = ButtonType.filled,
  });

  @override
  Widget build(BuildContext context) {
    // Base button style
    final buttonStyle = buttonType == ButtonType.filled
        ? ElevatedButton.styleFrom(
            backgroundColor: isButtonDisabled == true
                ? AppTheme.disabledButtonColor
                : AppTheme.activeButtonColor,
            foregroundColor: AppTheme.witeText,
            minimumSize: const Size(354, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            disabledBackgroundColor: AppTheme.disabledButtonColor,
          )
        : OutlinedButton.styleFrom(
            backgroundColor: Colors.transparent,
            side: BorderSide(
              color: isButtonDisabled == true
                  ? AppTheme.disabledButtonColor
                  : AppTheme.activeButtonColor,
              width: 1,
            ),
            minimumSize: const Size(354, 44),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          );

    // Build the button based on the buttonType
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 354),
      child: buttonType == ButtonType.filled
          ? ElevatedButton(
              onPressed: isButtonDisabled == true ? null : onPressed,
              style: buttonStyle,
              child: Text(
                text,
                style: const TextStyle(
                  color: AppTheme.witeText,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : OutlinedButton(
              onPressed: isButtonDisabled == true ? null : onPressed,
              style: buttonStyle,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: isButtonDisabled == true
                      ? AppTheme.disabledButtonColor
                      : AppTheme.activeButtonColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}
