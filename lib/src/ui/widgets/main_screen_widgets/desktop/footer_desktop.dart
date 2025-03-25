import 'package:flutter/material.dart';

import '../../../../utils/auth_validator.dart';
import '../../../themes/app_theme.dart';
import 'language_selector.dart';

class FooterSection extends StatelessWidget {
  FooterSection({super.key});

  final List<Map<String, dynamic>> listSections = [
    {
      'title': 'Сторінки',
      'items': [
        'Категорії',
        'Сезонні пропозиції',
        'Нові оголошення',
        'Сповіщення',
        'Відгуки',
        'Рекомендовані товари',
        'Історія',
      ],
    },
    {
      'title': 'Інше',
      'items': [
        'Доставка та оплата',
        'Питання',
        'Пошук',
        'Продати',
        'Чат',
        'Обране',
      ],
    },
    {
      'title': 'Контакти',
      'items': [
        'Про нас',
        'Підтримка',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 12),
      decoration: BoxDecoration(
        color: AppTheme.greyBoxColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Image.asset(
                  'assets/images/logo_desktop.png',
                  width: 36,
                  height: 46,
                ),
                const SizedBox(width: 60),
                ...listSections.map((section) => Padding(
                      padding: const EdgeInsets.only(right: 70),
                      child:
                          _buildListSection(section['title'], section['items']),
                    )),
              ]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const LanguageSelector(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                  TokenBasedWidget(child: _buildStoreLinks()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Text(
            '© shum.ua, 2024-2025',
            style: TextStyle(fontSize: 14, color: AppTheme.blackText),
          ),
        ],
      ),
    );
  }

  Widget _buildListSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.blackText),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => _buildListItem(item)).toList(),
        ),
      ],
    );
  }

  Widget _buildListItem(String text) {
    return HoverableLink(text: text);
  }
}

class HoverableLink extends StatefulWidget {
  final String text;

  const HoverableLink({super.key, required this.text});

  @override
  _HoverableLinkState createState() => _HoverableLinkState();
}

class _HoverableLinkState extends State<HoverableLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: GestureDetector(
        onTap: () {
          // tap functionality
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            style: TextStyle(
              fontSize: 14,
              color: _isHovered
                  ? AppTheme.linkTextColor
                  : const Color.fromARGB(255, 79, 79, 79),
              decoration: TextDecoration.none,
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}

Widget _buildStoreLinks() {
  return Wrap(
    spacing: 10, // Horizontal space between children
    runSpacing: 10,
    children: [
      // Google Play Link
      GestureDetector(
        onTap: () {
          // link
        },
        child: Image.asset(
          'assets/images/main_icons/google_play.png',
          width: 162,
          height: 60,
        ),
      ),
      const SizedBox(width: 10),
      // App Store Link
      GestureDetector(
        onTap: () {
          // link
        },
        child: Image.asset(
          'assets/images/main_icons/app_store.png',
          width: 162,
          height: 60,
        ),
      ),
    ],
  );
}
