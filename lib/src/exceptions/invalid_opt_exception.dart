class InvalidOtpException implements Exception {
  final String message;

  InvalidOtpException([this.message = 'Упс! Код невірний. Спробуйте знову.']);

  @override
  String toString() {
    return message;
  }
}
