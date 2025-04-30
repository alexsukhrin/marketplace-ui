import 'package:flutter/material.dart';

class BreadcrumbItem {
  final String label;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.label, this.onTap});
}

class BreadcrumbNavigation extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const BreadcrumbNavigation({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: List.generate(items.length * 2 - 1, (index) {
        if (index.isOdd) {
          return const Text(
            '>',
            style: TextStyle(color: Colors.grey),
          );
        }

        final item = items[index ~/ 2];
        final isLast = index == items.length * 2 - 2;
        final isClickable = item.onTap != null;

        final text = Text(
          item.label,
          style: TextStyle(
            color: isLast ? Colors.orange : Colors.black87,
            fontWeight: isLast ? FontWeight.w500 : FontWeight.normal,
            decoration: null,
          ),
        );

        return isClickable
            ? MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: item.onTap,
                  child: text,
                ),
              )
            : text;
      }),
    );
  }
}
