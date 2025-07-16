import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class OptionField<T> extends FormField<List<int>> {
  final String labelText;
  final TextEditingController controller;
  final Future<List<T>> Function() getOptions;
  final String Function(T option) getOptionName;
  final int Function(T option) getOptionId;

  OptionField({
    super.key,
    required this.labelText,
    required this.controller,
    required this.getOptions,
    required this.getOptionName,
    required this.getOptionId,
    super.validator,
  }) : super(
          initialValue: [],
          builder: (FormFieldState<List<int>> state) {
            return _OptionFieldContent<T>(
              labelText: labelText,
              controller: controller,
              validator: validator,
              formState: state,
              getOptions: getOptions,
              getOptionName: getOptionName,
              getOptionId: getOptionId,
            );
          },
        );
}

class _OptionFieldContent<T> extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final FormFieldValidator<List<int>>? validator;
  final FormFieldState<List<int>> formState;
  final Future<List<T>> Function() getOptions;
  final String Function(T option) getOptionName;
  final int Function(T option) getOptionId;

  const _OptionFieldContent({
    super.key,
    required this.labelText,
    required this.controller,
    required this.validator,
    required this.formState,
    required this.getOptions,
    required this.getOptionName,
    required this.getOptionId,
  });

  @override
  _OptionFieldContentState<T> createState() => _OptionFieldContentState<T>();
}

class _OptionFieldContentState<T> extends State<_OptionFieldContent<T>> {
  late Future<List<T>> _optionsFuture;
  List<T> _options = [];
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _optionsFuture = widget.getOptions();
    _optionsFuture.then((options) {
      setState(() {
        _options = options;
        _isDataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedIds = widget.formState.value ?? [];
    final hasError = widget.formState.hasError;

    void onSelect(int id) {
      setState(() {
        final updated = List<int>.from(selectedIds);
        if (updated.contains(id)) {
          updated.remove(id);
        } else {
          updated.add(id);
        }
        widget.controller.text = updated.join(',');
        widget.formState.didChange(updated);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppTheme.blackText),
        ),
        const SizedBox(height: 8),
        _isDataLoaded
            ? Column(
                children: _options.map((option) {
                  final isSelected =
                      selectedIds.contains(widget.getOptionId(option));

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => onSelect(widget.getOptionId(option)),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 14, horizontal: 20),
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
                          widget.getOptionName(option),
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
              )
            : const Center(child: CircularProgressIndicator()),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Text(
              widget.formState.errorText!,
              style: const TextStyle(
                color: AppTheme.textError,
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
