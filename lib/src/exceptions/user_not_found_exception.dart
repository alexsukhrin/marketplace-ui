class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException([this.message = 'Користувача не знайдено.']);

  @override
  String toString() {
    return message;
  }
}
