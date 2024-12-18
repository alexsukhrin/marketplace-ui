import 'package:flutter/material.dart';

class FormHeader extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;

  const FormHeader({
    super.key,
    required this.text,
    this.icon = Icons.beach_access,
    this.iconColor = Colors.red,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 28,
          color: iconColor,
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: textTheme.bodyMedium?.copyWith(),
        ),
      ],
    );
  }
}
