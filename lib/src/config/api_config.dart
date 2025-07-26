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
  static String get authRegister => '$baseUrl/api/auth/register/';
  static String get authLogin => '$baseUrl/api/auth/login/';
  static String get authResetPassword => '$baseUrl/api/auth/reset-password/';
  static String get authRefresh => '$baseUrl/api/auth/refresh/';
  static String get authOtp => '$baseUrl/api/auth/otp/';
  static String get authUpdatePassword => '$baseUrl/api/auth/update-password/';

  static String get usersCreate => '$baseUrl/api/users/create/';
  static String get usersCategories => '$baseUrl/api/users/categories/';

  static String get productsCreate => '$baseUrl/api/products/create/';
  static String get productsCategories => '$baseUrl/api/products/categories/';
  static String get products => '$baseUrl/api/products/';

  // Product options
  static String get shoeSizes => '$baseUrl/api/products/options/shoe-sizes/';
  static String get clothingSizes => '$baseUrl/api/products/options/clothing-sizes/';
  static String get colors => '$baseUrl/api/products/options/colors/';
  static String get genders => '$baseUrl/api/products/options/genders/';
  static String get materials => '$baseUrl/api/products/options/materials/';
  static String get paymentOptions => '$baseUrl/api/products/payment-options/';
  static String get deliveryOptions => '$baseUrl/api/products/delivery-options/';
}
