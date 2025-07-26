import 'package:http/http.dart' as http;
import 'dart:convert';

import '../exceptions/email_already_registered_exception.dart';
import 'auth_storage.dart';
import '../config/api_config.dart';
import 'token_manager.dart';

class AuthService {
  static Future<void> registerUser(Map<String, String> formData) async {
    final url = Uri.parse(ApiConfig.authRegister);

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
        if (responseBody.containsKey('tokens') &&
            responseBody.containsKey('user')) {
          final tokens = responseBody['tokens'];
          final accessToken = tokens['access'];
          final refreshToken = tokens['refresh'];

          if (accessToken != null && refreshToken != null) {
            // Використовуємо TokenManager для зберігання токенів та запуску auto-refresh
            await TokenManager.instance.setTokens(
              accessToken: accessToken,
              refreshToken: refreshToken,
            );
            print(
                'Користувач зареєстрований: ${responseBody['user']['email']}');
          } else {
            throw Exception('Токени не знайдено в відповіді сервера.');
          }
        } else {
          throw Exception('Відповідь сервера не містить очікуваних полів.');
        }
      } else if (response.statusCode == 400) {
        // Обробка помилок валідації
        if (responseBody.containsKey('email')) {
          final emailErrors = responseBody['email'];
          if (emailErrors.toString().contains('already exists')) {
            throw EmailAlreadyRegisteredException(
                'Користувач з такою поштою вже існує.');
          }
        }

        // Загальна помилка валідації
        final errorMessages = <String>[];
        responseBody.forEach((field, errors) {
          if (errors is List) {
            errorMessages.addAll(errors.map((e) => '$field: $e'));
          } else {
            errorMessages.add('$field: $errors');
          }
        });

        throw Exception('Помилка валідації:\n${errorMessages.join('\n')}');
      } else {
        throw Exception('Помилка реєстрації: ${response.statusCode}');
      }
    } catch (e) {
      print('Помилка підключення: $e');
      rethrow; // ✅ Пробрасуємо помилку далі до UI
    }
  }

  /// Вихід користувача (logout)
  static Future<void> logout() async {
    await TokenManager.instance.clearTokens();
    print('Користувач вийшов з системи');
  }

  /// Перевіряє чи користувач авторизований
  static Future<bool> isLoggedIn() async {
    final token = await TokenManager.instance.getValidAccessToken();
    return token != null;
  }

  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final url = Uri.parse(ApiConfig.authLogin);

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

        // Перевіряємо новий формат відповіді
        if (responseData.containsKey('tokens')) {
          final tokens = responseData['tokens'];
          final accessToken = tokens['access'];
          final refreshToken = tokens['refresh'];

          if (accessToken != null && refreshToken != null) {
            await TokenManager.instance.setTokens(
              accessToken: accessToken,
              refreshToken: refreshToken,
            );
          }
        }
        // Підтримка старого формату (якщо потрібно)
        else if (responseData.containsKey('access-token')) {
          await TokenManager.instance.setTokens(
            accessToken: responseData['access-token'],
            refreshToken: responseData['refresh-token'],
          );
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
    final url = Uri.parse(ApiConfig.authResetPassword);

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
    final url = Uri.parse(ApiConfig.authRefresh);
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
