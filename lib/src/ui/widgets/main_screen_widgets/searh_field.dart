import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../themes/app_theme.dart';

class SearchField extends StatelessWidget {
  final String placeholder;
  final VoidCallback onSearch;

  const SearchField({
    super.key,
    this.placeholder = "Я шукаю...",
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.textFieldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: onSearch,
            child: SvgPicture.asset(
              'assets/images/footer_icons/search.svg',
              width: 20,
              height: 20,
              colorFilter:
                  const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                hintText: placeholder,
                hintStyle: const TextStyle(color: Colors.black54),
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
