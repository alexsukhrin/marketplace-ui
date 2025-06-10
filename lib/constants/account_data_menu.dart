import 'package:flutter_application_1/models/account_menu.dart';

final List<AccountMenu> accountMenuItems = [
  AccountMenu(
    id: "account",
    title: "Акаунт",
    icon: "assets/images/account_menu_icons/account.png",
  ),
  AccountMenu(
    id: "messages",
    title: "Повідомлення",
    icon: "assets/images/account_menu_icons/message.png",
  ),
  AccountMenu(
      id: "announcements",
      title: "Оголошення",
      icon: "assets/images/account_menu_icons/announcements.png",
      text: "У вас ще немає активних оголошень",
      subtext:
          "Оголошення з’являться тут після того як успішно пройдуть модерацію."),
  AccountMenu(
      id: "moderation",
      title: "На модерації",
      icon: "assets/images/account_menu_icons/moderation.png",
      text: "У вас немає оголошень на модерації",
      subtext:
          "Як тільки ви викладете нове оголошення наші модератори його переглянуть."),
  AccountMenu(
    id: "rejected",
    title: "Відхилені",
    icon: "assets/images/account_menu_icons/rejected.png",
    text: "У вас немає відхилених оголошень",
  ),
  AccountMenu(
    id: "analytics",
    title: "Аналітика",
    icon: "assets/images/account_menu_icons/analytics.png",
  ),
  AccountMenu(
    id: "wallets",
    title: "Кошти",
    icon: "assets/images/account_menu_icons/wallets.png",
  ),
  AccountMenu(
    id: "return",
    title: "Повернення",
    icon: "assets/images/account_menu_icons/rotate.png",
  ),
  AccountMenu(
    id: "help",
    title: "Допомога",
    icon: "assets/images/account_menu_icons/help.png",
  ),
  AccountMenu(
    id: "settings",
    title: "Налаштування",
    icon: "assets/images/account_menu_icons/setting.png",
  ),
];
