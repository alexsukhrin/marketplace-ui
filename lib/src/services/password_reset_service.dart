import 'package:http/http.dart' as http;
import 'dart:convert';

import '../exceptions/invalid_opt_exception.dart';
import '../exceptions/user_not_found_exception.dart';

class PasswordResetService {
  static String? _token;
  static const String _baseUrl =
      'http://ec2-18-193-77-42.eu-central-1.compute.amazonaws.com';

  static Future<Map<String, dynamic>> sendRecoveryEmail(String email) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/reset-password');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final errorResponse = jsonDecode(response.body);

        if (response.statusCode == 404 &&
            errorResponse['error'] == 'User not found.') {
          throw UserNotFoundException('Ця пошта не зареєстрована');
        }

        throw Exception(errorResponse['error'] ?? 'Невідома помилка');
      }
    } catch (e) {
      print('Caught error: $e');
      rethrow;
    }
  }

  static Future<void> validateRecoveryCode(String email, String code) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/otp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email, 'otp': code}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _token = responseData['token'];
      } else if (response.statusCode == 403) {
        final errorResponse = jsonDecode(response.body);
        if (errorResponse['error'] == 'Otp not verified') {
          throw InvalidOtpException('Упс! Код невірний. Спробуйте знову.');
        }
        throw Exception('Помилка: ${response.body}');
      } else {
        throw Exception('Помилка: ${response.body}');
      }
    } catch (e) {
      print("error");
      if (e is InvalidOtpException) {
        rethrow;
      }
      throw Exception('Помилка підключення до сервера');
    }
  }

  static Future<void> resetPassword(String newPassword) async {
    if (_token == null) {
      throw Exception(
          'Токен відсутній. Спочатку виконайте validateRecoveryCode.');
    }
    final url = Uri.parse('$_baseUrl/api/v1/auth/update-password');

    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({'password': newPassword}),
      );

      if (response.statusCode == 200) {
        print('Пароль успішно змінено: ${response.body}');
      } else {
        print('Помилка зміни паролю: ${response.statusCode} ${response.body}');
        throw Exception('Помилка: ${response.body}');
      }
    } catch (e) {
      print('Помилка підключення: $e');
      throw Exception('Помилка підключення до сервера');
    }
  }
}
