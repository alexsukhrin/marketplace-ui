import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class ProductDescriptionField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final String? errorText;

  const ProductDescriptionField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    this.validator,
    this.errorText,
  });

  @override
  _ProductDescriptionFieldState createState() =>
      _ProductDescriptionFieldState();
}

class _ProductDescriptionFieldState extends State<ProductDescriptionField> {
  bool _isFieldTouched = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool showError = widget.errorText != null && _isFieldTouched;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: textTheme.bodyMedium?.copyWith(color: AppTheme.blackText),
        ),
        const SizedBox(height: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 781),
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
                      color:
                          showError ? AppTheme.textError : Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: showError
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
                ),
                maxLines: 3,
                minLines: 3,
                validator: widget.validator,
                onChanged: (_) {
                  setState(() {
                    _isFieldTouched = true;
                  });
                },
                onTap: () {
                  setState(() {
                    _isFieldTouched = true;
                  });
                },
              ),
              if (showError)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.errorText!,
                    style: const TextStyle(
                      color: AppTheme.textError,
                      fontSize: 13,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
