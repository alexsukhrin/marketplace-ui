import 'package:flutter/material.dart';
import '../../utils/validators.dart';
import '../themes/app_theme.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController? controller;
  final bool showCounter;
  final String labelText;

  const PasswordField({
    super.key,
    this.controller,
    this.showCounter = false,
    required this.labelText,
    required String? Function(String? value) validator,
  });

  @override
  PasswordFieldState createState() => PasswordFieldState();
}

class PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        widget.controller ?? TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: !_passwordVisible,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: const TextStyle(
              color: AppTheme.headingTextColor,
            ),
            border: const OutlineInputBorder(),
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
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
          ),
          validator: validatePassword,
        ),
        if (widget.showCounter)
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
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
