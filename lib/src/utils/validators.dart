// lib/src/utils/validators.dart

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Будь ласка, введіть електронну пошту';
  }
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Електронна адреса недійсна';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Будь ласка, введіть пароль';
  }
  final passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).{8,}$');
  if (!passwordRegex.hasMatch(value)) {
    return 'Пароль має бути не менше 8 символів, включати велику літеру, цифру та спеціальний символ';
  }
  return null;
}
