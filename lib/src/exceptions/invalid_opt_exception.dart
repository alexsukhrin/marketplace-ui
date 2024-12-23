class InvalidOtpException implements Exception {
  final String message;

  InvalidOtpException([this.message = 'Невірний код']);

  @override
  String toString() {
    return message;
  }
}
