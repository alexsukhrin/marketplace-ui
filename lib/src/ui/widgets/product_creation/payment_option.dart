import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class PaymentOptionField extends FormField<String> {
  PaymentOptionField({
    super.key,
    required String labelText,
    required TextEditingController controller,
    FormFieldValidator<String>? validator,
  }) : super(
          initialValue: controller.text,
          validator: validator,
          builder: (FormFieldState<String> state) {
            final options = ['Оплата при отриманні', 'Оплата SHUM'];
            final selected = controller.text;
            final hasError = state.hasError;

            void _onSelect(String option) {
              controller.text = option;
              state.didChange(option);
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelText,
                  style: Theme.of(state.context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppTheme.blackText),
                ),
                const SizedBox(height: 8),
                Column(
                  children: options.map((option) {
                    final isSelected = selected == option;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => _onSelect(option),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.textFieldBackgroundColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: hasError
                                  ? AppTheme.textError
                                  : isSelected
                                      ? AppTheme.activeBorderColor
                                      : Colors.transparent,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            option,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.blackText,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: AppTheme.textError,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            );
          },
        );
}
