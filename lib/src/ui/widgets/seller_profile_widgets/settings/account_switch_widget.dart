import 'package:flutter/material.dart';

class AccountSwitchWidget extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const AccountSwitchWidget({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 150, child: Text(label)),
        const SizedBox(width: 120),
        SwitchTheme(
          data: SwitchThemeData(
            trackColor: WidgetStateProperty.resolveWith<Color?>(
              (states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.orange;
                }
                return Colors.grey.shade300;
              },
            ),
            thumbColor: WidgetStateProperty.all(Colors.white),
            trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          ),
          child: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 12),
        Text(value ? 'Вкл.' : 'Викл.'),
      ],
    );
  }
}
