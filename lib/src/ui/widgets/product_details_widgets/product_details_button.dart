import 'package:flutter/material.dart';

class ProductDetailsButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final bool hasIcon;
  final IconData? iconData;
  final bool isPrimary;

  const ProductDetailsButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.width,
    required this.height,
    this.hasIcon = false,
    this.iconData,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: isPrimary ? Colors.white : Colors.orange,
          backgroundColor: isPrimary ? Colors.orange : Colors.transparent,
          side: const BorderSide(color: Colors.orange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) ||
                states.contains(WidgetState.pressed)) {
              return const Color.fromRGBO(255, 165, 0, 0.2);
            }
            return null;
          }),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (hasIcon && iconData != null) ...[
              Icon(iconData,
                  size: 20, color: isPrimary ? Colors.white : Colors.orange),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: TextStyle(
                color: isPrimary ? Colors.white : Colors.orange,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
