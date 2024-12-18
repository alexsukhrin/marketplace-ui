import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final bool? showCounter;
  final TextEditingController controller;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final String labelText;

  const AuthField({
    super.key,
    required this.hintText,
    this.showCounter,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
    this.validator,
  });

  @override
  _AuthFieldState createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = !widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: textTheme.bodyMedium?.copyWith(color: AppTheme.blackText),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: AppTheme.hintTesxtGrey,
            ),
            fillColor: AppTheme.textFieldBackgroundColor,
            filled: true,
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
            suffixIcon: widget.isObscureText
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  )
                : null,
          ),
          validator: widget.validator,
          obscureText: !_isPasswordVisible,
        ),
        if (widget.showCounter == true)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.controller,
                builder: (context, value, child) {
                  final passwordLength = value.text.length;
                  return Text(
                    '$passwordLength/8',
                    style: TextStyle(
                      color: passwordLength >= 8
                          ? AppTheme.textFieldValidColor
                          : AppTheme.textFieldCounterColor,
                    ),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }
}
