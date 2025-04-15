import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class AuthField extends StatefulWidget {
  final String hintText;
  final bool? showCounter;
  final TextEditingController controller;
  final bool isObscureText;
  final String? Function(String?)? validator;
  final String labelText;
  final bool Function(String)? showSuffixIcon;
  final String? errorText;
  final double? maxWidth;

  const AuthField({
    super.key,
    required this.hintText,
    this.showCounter,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
    this.validator,
    this.showSuffixIcon,
    this.errorText,
    this.maxWidth,
  });

  @override
  AuthFieldState createState() => AuthFieldState();
}

class AuthFieldState extends State<AuthField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = !widget.isObscureText;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isValid =
        widget.showSuffixIcon?.call(widget.controller.text) ?? false;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: textTheme.bodyMedium?.copyWith(color: AppTheme.blackText),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth ?? 354,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: const TextStyle(
                    color: AppTheme.hintTesxtGrey,
                  ),
                  fillColor: AppTheme.textFieldBackgroundColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null
                          ? AppTheme.textError
                          : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: widget.errorText != null
                          ? AppTheme.textError
                          : AppTheme.activeBorderColor,
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
                      : isValid
                          ? const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : null,
                  // errorText: widget.errorText,
                  errorMaxLines: 3,
                ),
                validator: widget.validator,
                obscureText: !_isPasswordVisible,
                onChanged: (_) {
                  setState(() {});
                },
              ),
              if (widget.showCounter == true || widget.errorText != null)
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: [
                      if (widget.errorText != null)
                        Expanded(
                          child: Text(
                            widget.errorText!,
                            style: const TextStyle(
                              color: AppTheme.textError,
                              fontSize: 13,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        const Spacer(),
                      if (widget.showCounter == true)
                        ValueListenableBuilder<TextEditingValue>(
                          valueListenable: widget.controller,
                          builder: (context, value, child) {
                            final passwordLength = value.text.length;
                            return Text(
                              '8/$passwordLength',
                              style: TextStyle(
                                color: passwordLength >= 8
                                    ? AppTheme.textFieldValidColor
                                    : AppTheme.textFieldCounterColor,
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
