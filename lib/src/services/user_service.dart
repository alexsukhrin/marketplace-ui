import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import 'token_manager.dart';

/// Приклад сервісу який використовує автентифіковані запити
class UserService {
  /// Отримує профіль поточного користувача
  static Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final response = await AuthenticatedHttpClient.get(
        Uri.parse('${ApiConfig.baseUrl}/api/users/me/'),
      );

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        if (kDebugMode) {
          print('👤 UserService: Профіль користувача отримано');
        }
        return userData;
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print('🔐 UserService: Токен не валідний, потрібна авторизація');
        }
        return null;
      } else {
        if (kDebugMode) {
          print('❌ UserService: Помилка ${response.statusCode}');
        }
        throw Exception('Помилка отримання профілю користувача');
      }
    } catch (e) {
      if (kDebugMode) {
        print('💥 UserService: Exception: $e');
      }
      rethrow;
    }
  }

  /// Оновлює профіль користувача
  static Future<bool> updateUserProfile(Map<String, dynamic> userData) async {
    try {
      final response = await AuthenticatedHttpClient.put(
        Uri.parse('${ApiConfig.baseUrl}/api/users/me/'),
        body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('✅ UserService: Профіль оновлено');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('❌ UserService: Помилка оновлення ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('💥 UserService: Exception: $e');
      }
      return false;
    }
  }

  /// Створює роль користувача (використовує існуючий endpoint)
  static Future<void> createUserRole(Map<String, bool> role) async {
    try {
      final response = await AuthenticatedHttpClient.post(
        Uri.parse(ApiConfig.usersCreate),
        body: jsonEncode(role),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          print('✅ UserService: Роль користувача створена');
        }
      } else {
        if (kDebugMode) {
          print('❌ UserService: Помилка створення ролі ${response.statusCode}');
        }
        throw Exception('Помилка створення ролі користувача');
      }
    } catch (e) {
      if (kDebugMode) {
        print('💥 UserService: Exception при створенні ролі: $e');
      }
      rethrow;
    }
  }
} 