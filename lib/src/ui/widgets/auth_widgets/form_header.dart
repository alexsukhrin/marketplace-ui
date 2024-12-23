import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormHeader extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final String iconPath;

  const FormHeader({
    super.key,
    required this.text,
    this.icon = Icons.beach_access,
    this.iconColor = Colors.red,
    this.iconPath = 'assets/images/logo.svg',
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          iconPath,
          width: 28,
          height: 28,
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
