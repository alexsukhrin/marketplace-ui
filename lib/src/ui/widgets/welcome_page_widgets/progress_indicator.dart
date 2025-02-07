import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class ProgressIndicatorRow extends StatelessWidget {
  final List<String> order;
  final MainAxisAlignment alignment;

  const ProgressIndicatorRow({
    super.key,
    required this.order,
    this.alignment = MainAxisAlignment.center,
  });

  Widget _buildIndicator(String type) {
    switch (type) {
      case "active":
        return Container(
          height: 6,
          width: 30,
          decoration: BoxDecoration(
            color: AppTheme.progressIndicatorActive,
            borderRadius: BorderRadius.circular(3),
          ),
        );
      case "inactive":
        return Container(
          height: 6,
          width: 6,
          decoration: const BoxDecoration(
            color: AppTheme.progressIndicatorInactive,
            shape: BoxShape.circle,
          ),
        );
      case "space":
        return const SizedBox(width: 4);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment,
      children: order.map((type) => _buildIndicator(type)).toList(),
    );
  }
}
