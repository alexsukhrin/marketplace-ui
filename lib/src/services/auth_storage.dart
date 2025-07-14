import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static FlutterSecureStorage? _secureStorage;
  static SharedPreferences? _prefs;
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  static Future<void> init() async {
    if (kIsWeb) {
      _prefs = await SharedPreferences.getInstance();
    } else {
      _secureStorage = const FlutterSecureStorage();
    }
  }

  static Future<void> saveAccessToken(String token) async {
    if (kIsWeb) {
      await _prefs?.setString(_accessTokenKey, token);
    } else {
      await _secureStorage?.write(key: _accessTokenKey, value: token);
    }
  }

  static Future<void> saveRefreshToken(String token) async {
    if (kIsWeb) {
      await _prefs?.setString(_refreshTokenKey, token);
    } else {
      await _secureStorage?.write(key: _refreshTokenKey, value: token);
    }
  }

  static Future<String?> getAccessToken() async {
    return kIsWeb
        ? _prefs?.getString(_accessTokenKey)
        : await _secureStorage?.read(key: _accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return kIsWeb
        ? _prefs?.getString(_refreshTokenKey)
        : await _secureStorage?.read(key: _refreshTokenKey);
  }

  static Future<void> deleteTokens() async {
    if (kIsWeb) {
      await _prefs?.remove(_accessTokenKey);
      await _prefs?.remove(_refreshTokenKey);
    } else {
      await _secureStorage?.delete(key: _accessTokenKey);
      await _secureStorage?.delete(key: _refreshTokenKey);
    }
    print('Access & refresh tokens deleted');
  }
}
