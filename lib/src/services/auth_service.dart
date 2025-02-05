import 'package:http/http.dart' as http;
import 'dart:convert';

import '../exceptions/email_already_registered_exception.dart';
import 'auth_storage.dart';

class AuthService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

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
        final responseBody = jsonDecode(response.body);
        final token = responseBody['token'];
        final message = responseBody['message'];

        if (token != null) {
          await AuthStorage.saveToken(token);
          print(message);
        } else {
          throw Exception('Token not found in the response.');
        }
      } else if (response.statusCode == 400) {
        final responseBody = jsonDecode(response.body);
        if (responseBody['error'] == "User data not valid.") {
          throw EmailAlreadyRegisteredException(
              'Упс, така пошта вже використовується.');
        } else {
          throw Exception('Невідома помилка реєстрації');
        }
      } else {
        throw Exception('Помилка реєстрації: ${response.statusCode}');
      }
    } catch (e) {
      print('Помилка підключення: $e');
      rethrow;
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
