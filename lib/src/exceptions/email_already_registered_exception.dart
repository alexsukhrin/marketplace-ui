class EmailAlreadyRegisteredException implements Exception {
  final String message;
  EmailAlreadyRegisteredException(this.message);
}
