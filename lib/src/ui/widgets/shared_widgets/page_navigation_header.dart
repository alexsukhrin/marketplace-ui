import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/widgets/bread_crumb_navigation.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.currentPage,
    this.onMenuItemSelected,
  });
  final String currentPage;
  final void Function(String)? onMenuItemSelected;

  String? getPageTitle() {
    switch (currentPage) {
      case 'favorites':
        return "Обране";
      case 'cart':
        return "Кошик";
      case 'chat':
        return "Чат";
      case 'sell':
        return 'Нове оголошення';
      case 'notifications':
        return "Сповіщення";
      case 'delivery':
        return "Доставка";
      case 'about':
        return "About";
      case 'home':
        return null;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = getPageTitle();

    if (title == null) return const SizedBox.shrink();

    return BreadcrumbNavigation(
      items: [
        BreadcrumbItem(
          label: 'Головна',
          onTap: onMenuItemSelected != null
              ? () => onMenuItemSelected!('home')
              : null,
        ),
        BreadcrumbItem(label: title),
      ],
    );
  }
}
