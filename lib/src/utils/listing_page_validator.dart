String? validateProductName(String? value) {
  if (value == null || value.isEmpty) {
    return 'Це поле обов’язкове для заповнення';
  } else if (value.length > 30) {
    return 'Назва товару не може перевищувати 30 символів';
  }
  return null;
}

String? validateProductDescription(String? value) {
  if (value == null || value.isEmpty) {
    return 'Це поле обов’язкове для заповнення';
  }
  if (value.length < 30) {
    return 'Опис повинен бути не менше 30 символів';
  }
  if (value.length > 500) {
    return 'Опис не може перевищувати 500 символів';
  }
  return null;
}

String? validateCondition(String? condition) {
  if (condition == null || condition.isEmpty) {
    return 'Оберіть стан товару';
  }
  return null;
}

String? validatePrice(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Це поле обов’язкове для заповнення';
  }
  final numericRegex = RegExp(r'^\d+$');
  if (!numericRegex.hasMatch(value)) {
    return 'Введіть тільки цифри';
  }
  return null;
}

String? validateDelivery(String? value) {
  if (value == null || value.isEmpty) {
    return 'Будь ласка, оберіть спосіб доставки';
  }
  return null;
}

String? validatePhoneNumber(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Це поле обовʼязкове для заповнення';
  }
  final numericRegex = RegExp(r'^\d{10}$');
  if (!numericRegex.hasMatch(value)) {
    return 'Номер телефону повинен містити тільки 10 цифр';
  }
  return null;
}

String? validatePaymentOption(List<int>? value) {
  if (value == null || value.isEmpty) {
    return 'Оберіть спосіб оплати';
  }
  return null;
}

String? validateDeliveryOption(List<int>? value) {
  if (value == null || value.isEmpty) {
    return 'Оберіть спосіб доставки';
  }
  return null;
}
