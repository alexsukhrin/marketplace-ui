import 'package:http/http.dart' as http;
import 'dart:convert';

import '../exceptions/email_already_registered_exception.dart';
import 'auth_storage.dart';

class AuthService {
  static const String _baseUrl =
      'http://ec2-18-153-92-5.eu-central-1.compute.amazonaws.com:8032';

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

      final responseBody = jsonDecode(response.body);
      print('Response body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (responseBody.containsKey('token') &&
            responseBody.containsKey('message')) {
          final accessToken = responseBody['access-token'];
          final refreshToken = responseBody['refresh-token'];
          final message = responseBody['message'] ?? 'Повідомлення не надано';

          if (accessToken != null && refreshToken != null) {
            await AuthStorage.saveAccessToken(accessToken);
            await AuthStorage.saveRefreshToken(refreshToken);
            print(message);
          } else {
            throw Exception('Token not found in the response.');
          }
        } else {
          throw Exception('Response body does not contain expected fields.');
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

        if (responseData.containsKey('access-token')) {
          await AuthStorage.saveAccessToken(responseData['access-token']);
        }
        if (responseData.containsKey('refresh-token')) {
          await AuthStorage.saveRefreshToken(responseData['refresh-token']);
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

  static Future<bool> refreshAccessToken() async {
    final url = Uri.parse('$_baseUrl/api/v1/auth/refresh');
    final refreshToken = await AuthStorage.getRefreshToken();

    if (refreshToken == null) {
      print('Refresh-token відсутній');
      return false;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('access-token')) {
          await AuthStorage.saveAccessToken(responseData['access-token']);
        }
        if (responseData.containsKey('refresh-token')) {
          await AuthStorage.saveRefreshToken(responseData['refresh-token']);
        }

        print('Токен успішно оновлено');
        return true;
      } else {
        print('Помилка оновлення токена: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Помилка при оновленні токена: $e');
      return false;
    }
  }
}
