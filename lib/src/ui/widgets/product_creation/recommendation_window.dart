import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/themes/app_theme.dart';

class RecommendationWindow extends StatefulWidget {
  const RecommendationWindow({super.key});

  @override
  State<RecommendationWindow> createState() => _RecommendationWindow();
}

class _RecommendationWindow extends State<RecommendationWindow> {
  bool _isVisible = true;

  void _hideWindow() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();
    return SizedBox(
      width: 435,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Рекомендаціії щодо оголошення',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 11),
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: AppTheme.sidebarColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
                'Використовуйте власні фото товару гарної якості. Опишіть розмір товару, де використовувався, чому продаєте тощо. Вкажіть ціну за одиницю товару та виберіть зручні варіанти оплати до доставки товару.'),
          ),
          const SizedBox(height: 11),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: _hideWindow,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.activeButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Дякую, корисно",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _hideWindow,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: AppTheme.activeButtonColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Не корисно",
                style: TextStyle(color: AppTheme.activeButtonColor),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
