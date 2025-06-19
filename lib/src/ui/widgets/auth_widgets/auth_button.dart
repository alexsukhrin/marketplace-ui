import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';

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
      constraints: const BoxConstraints(maxWidth: 409),
      child: ElevatedButton(
        onPressed: isButtonDisabled == true ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isButtonDisabled == true
              ? AppTheme.disabledButtonColor
              : AppTheme.activeButtonColor,
          foregroundColor: AppTheme.witeText,
          minimumSize: const Size(409, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBackgroundColor: AppTheme.disabledButtonColor,
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontSize: 18, color: TColors.white),
        ),
      ),
    );
  }
}
