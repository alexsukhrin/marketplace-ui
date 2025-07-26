import 'package:flutter/foundation.dart';

class ApiConfig {
  static const String _debugBaseUrl = 'http://localhost:8000';
  static const String _productionBaseUrl =
      'http://ec2-18-153-92-5.eu-central-1.compute.amazonaws.com:8032';

  /// Повертає базовий URL залежно від режиму (debug/production)
  static String get baseUrl {
    return kDebugMode ? _debugBaseUrl : _productionBaseUrl;
  }

  /// API endpoints
  static String get authRegister => '$baseUrl/api/v1/auth/register';
  static String get authLogin => '$baseUrl/api/v1/auth/login';
  static String get authResetPassword => '$baseUrl/api/v1/auth/reset-password';
  static String get authRefresh => '$baseUrl/api/v1/auth/refresh';
  static String get authOtp => '$baseUrl/api/v1/auth/otp';
  static String get authUpdatePassword =>
      '$baseUrl/api/v1/auth/update-password';

  static String get usersCreate => '$baseUrl/api/v1/users/create';
  static String get usersCategories => '$baseUrl/api/v1/users/categories';

  static String get productsCreate => '$baseUrl/api/v1/products/create';
  static String get productsCategories => '$baseUrl/api/v1/products/categories';
  static String get products => '$baseUrl/api/v1/products';

  // Product options
  static String get shoeSizes => '$baseUrl/api/v1/products/options/shoe-sizes';
  static String get clothingSizes =>
      '$baseUrl/api/v1/products/options/clothing-sizes';
  static String get colors => '$baseUrl/api/v1/products/options/colors';
  static String get genders => '$baseUrl/api/v1/products/options/genders';
  static String get materials => '$baseUrl/api/v1/products/options/materials';
  static String get paymentOptions =>
      '$baseUrl/api/v1/products/payment-options';
  static String get deliveryOptions =>
      '$baseUrl/api/v1/products/delivery-options';
}
