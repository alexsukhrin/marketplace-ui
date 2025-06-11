class AccountMenu {
  final String id;
  final String title;
  final String icon;
  final String? text;
  final String? subtext;

  AccountMenu(
      {required this.id,
      required this.title,
      required this.icon,
      this.text,
      this.subtext});
}
