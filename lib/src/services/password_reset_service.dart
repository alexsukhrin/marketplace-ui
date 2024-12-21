import 'package:http/http.dart' as http;
import 'dart:convert';

class PasswordResetService {
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
        final error =
            jsonDecode(response.body)['message'] ?? 'Невідома помилка';
        throw Exception('Помилка: $error');
      }
    } catch (e) {
      print('Помилка підключення: $e');
      throw Exception('Помилка підключення до сервера');
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
        body: jsonEncode({'email': email, 'opt': code}),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Помилка: ${response.body}');
      }
    } catch (e) {
      print("error");
      throw Exception('Помилка підключення до сервера');
    }
  }

  static Future<void> resetPassword(String newPassword) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/update-password');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
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
