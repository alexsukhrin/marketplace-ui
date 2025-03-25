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
  if (value.contains(' ')) {
    return 'Пароль не може містити пробіли';
  }
  final passwordRegex =
      RegExp(r'^(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*])[^\s]{8,}$');
  if (!passwordRegex.hasMatch(value)) {
    return 'Пароль має бути не менше 8 символів, включати велику літеру, цифру та спеціальний символ';
  }
  return null;
}

String? validateName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Це поле обов’язкове для заповнення';
  } else if (value.length <= 2) {
    return 'Ім’я/прізвище має бути довше 2 символів';
  } else if (!RegExp(r'^[a-zA-Zа-яА-ЯїЇєЄіІґҐʼ]+$').hasMatch(value)) {
    return 'Ім’я/прізвище може містити тільки літери';
  }
  return null;
}
