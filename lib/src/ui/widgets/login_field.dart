import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import '../../utils/validators.dart';

class LoginField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const LoginField({
    super.key,
    required this.labelText,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator ?? validateEmail,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(
          color: AppTheme.headingTextColor,
        ),
        filled: true,
        fillColor: AppTheme.textFieldBackgroundColor,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.activeBorderColor,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.textError,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppTheme.textError,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
