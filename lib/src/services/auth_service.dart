import 'package:http/http.dart' as http;
import 'dart:convert';

import 'auth_storage.dart';

class AuthService {
  static const String _baseUrl =
      'http://ec2-18-193-77-42.eu-central-1.compute.amazonaws.com';

  static Future<void> registerUser(Map<String, String> formData) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(formData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Користувача зареєстровано: ${response.body}');
      } else {
        print('Помилка реєстрації: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Помилка підключення: $e');
    }
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);

        if (responseData.containsKey('token')) {
          await AuthStorage.saveToken(responseData['token']);
        }

        print('Логін успішний: $responseData');
        return responseData;
      } else {
        print('Помилка логіну: ${response.statusCode} ${response.body}');
        return {
          'success': false,
          'message': 'Невірна електронна пошта або пароль',
        };
      }
    } catch (e) {
      print('Помилка підключення до API: $e');
      throw Exception('Помилка підключення до API: $e');
    }
  }

  static Future<void> sendRecoveryEmail(String email) async {
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
        print('Email для відновлення паролю надіслано: ${response.body}');
      } else {
        print(
            'Помилка відправлення email: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Помилка підключення: $e');
    }
  }
}
