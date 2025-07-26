import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'auth_storage.dart';
import '../config/api_config.dart';

class TokenManager {
  static TokenManager? _instance;
  static TokenManager get instance => _instance ??= TokenManager._();
  
  TokenManager._();
  
  Timer? _refreshTimer;
  bool _isRefreshing = false;
  
  /// Запускає автоматичне оновлення токенів кожні 14 хвилин
  void startAutoRefresh() {
    stopAutoRefresh(); // Зупиняємо попередній таймер
    
    _refreshTimer = Timer.periodic(
      const Duration(minutes: 14), // За 1 хвилину до закінчення
      (timer) async {
        await _refreshTokenIfNeeded();
      },
    );
    
    if (kDebugMode) {
      print('🔄 TokenManager: Auto-refresh запущено (кожні 14 хв)');
    }
  }
  
  /// Зупиняє автоматичне оновлення токенів
  void stopAutoRefresh() {
    _refreshTimer?.cancel();
    _refreshTimer = null;
  }
  
  /// Отримує валідний access token, оновлюючи його при потребі
  Future<String?> getValidAccessToken() async {
    final accessToken = await AuthStorage.getAccessToken();
    
    if (accessToken == null) {
      if (kDebugMode) {
        print('⚠️ TokenManager: Access token відсутній');
      }
      return null;
    }
    
    // Перевіряємо чи не закінчується термін дії токена
    if (_isTokenExpiringSoon(accessToken)) {
      if (kDebugMode) {
        print('⏰ TokenManager: Access token закінчується, оновлюємо...');
      }
      return await _refreshTokenIfNeeded();
    }
    
    return accessToken;
  }
  
  /// Оновлює access token використовуючи refresh token
  Future<String?> _refreshTokenIfNeeded() async {
    if (_isRefreshing) {
      if (kDebugMode) {
        print('🔄 TokenManager: Оновлення вже в процесі, чекаємо...');
      }
      // Чекаємо завершення поточного оновлення
      while (_isRefreshing) {
        await Future.delayed(const Duration(milliseconds: 100));
      }
      return await AuthStorage.getAccessToken();
    }
    
    _isRefreshing = true;
    
    try {
      final refreshToken = await AuthStorage.getRefreshToken();
      
      if (refreshToken == null) {
        if (kDebugMode) {
          print('❌ TokenManager: Refresh token відсутній');
        }
        return null;
      }
      
      final response = await http.post(
        Uri.parse(ApiConfig.authRefresh),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $refreshToken',
        },
      );
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        
        final newAccessToken = responseData['access'];
        final newRefreshToken = responseData['refresh'];
        
        if (newAccessToken != null) {
          await AuthStorage.saveAccessToken(newAccessToken);
          if (kDebugMode) {
            print('✅ TokenManager: Access token оновлено');
          }
        }
        
        if (newRefreshToken != null) {
          await AuthStorage.saveRefreshToken(newRefreshToken);
          if (kDebugMode) {
            print('✅ TokenManager: Refresh token оновлено');
          }
        }
        
        return newAccessToken;
      } else {
        if (kDebugMode) {
          print('❌ TokenManager: Помилка оновлення токена: ${response.statusCode}');
        }
        
        // Якщо refresh token не валідний, очищаємо все
        if (response.statusCode == 401) {
          await clearTokens();
        }
        
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ TokenManager: Помилка при оновленні токена: $e');
      }
      return null;
    } finally {
      _isRefreshing = false;
    }
  }
  
  /// Перевіряє чи закінчується термін дії токена незабаром (за 2 хвилини)
  bool _isTokenExpiringSoon(String token) {
    try {
      // Простий парсинг JWT без валідації підпису
      final parts = token.split('.');
      if (parts.length != 3) return true;
      
      final payload = parts[1];
      // Додаємо padding якщо потрібно
      final normalizedPayload = payload.padRight(
        payload.length + (4 - payload.length % 4) % 4, 
        '='
      );
      
      final decoded = utf8.decode(base64Url.decode(normalizedPayload));
      final payloadData = jsonDecode(decoded);
      
      final exp = payloadData['exp'];
      if (exp == null) return true;
      
      final expirationTime = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final now = DateTime.now();
      final timeUntilExpiration = expirationTime.difference(now);
      
      // Оновлюємо токен за 2 хвилини до закінчення
      return timeUntilExpiration.inMinutes <= 2;
    } catch (e) {
      if (kDebugMode) {
        print('⚠️ TokenManager: Помилка парсингу токена: $e');
      }
      return true; // Якщо не можемо розпарсити, краще оновити
    }
  }
  
  /// Очищає всі токени (logout)
  Future<void> clearTokens() async {
    stopAutoRefresh();
    await AuthStorage.clearTokens();
    if (kDebugMode) {
      print('🗑️ TokenManager: Усі токени очищено');
    }
  }
  
  /// Зберігає нові токени після логіну/реєстрації
  Future<void> setTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await AuthStorage.saveAccessToken(accessToken);
    await AuthStorage.saveRefreshToken(refreshToken);
    startAutoRefresh(); // Запускаємо автоматичне оновлення
    
    if (kDebugMode) {
      print('💾 TokenManager: Токени збережено, auto-refresh запущено');
    }
  }
}

/// Утіліта для HTTP запитів з автоматичним додаванням Authorization header
class AuthenticatedHttpClient {
  static Future<http.Response> get(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final authHeaders = await _getAuthHeaders();
    final finalHeaders = {...?headers, ...authHeaders};
    
    return await http.get(url, headers: finalHeaders);
  }
  
  static Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final authHeaders = await _getAuthHeaders();
    final finalHeaders = {...?headers, ...authHeaders};
    
    return await http.post(url, headers: finalHeaders, body: body);
  }
  
  static Future<http.Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
  }) async {
    final authHeaders = await _getAuthHeaders();
    final finalHeaders = {...?headers, ...authHeaders};
    
    return await http.put(url, headers: finalHeaders, body: body);
  }
  
  static Future<http.Response> delete(
    Uri url, {
    Map<String, String>? headers,
  }) async {
    final authHeaders = await _getAuthHeaders();
    final finalHeaders = {...?headers, ...authHeaders};
    
    return await http.delete(url, headers: finalHeaders);
  }
  
  static Future<Map<String, String>> _getAuthHeaders() async {
    final token = await TokenManager.instance.getValidAccessToken();
    
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }
} 