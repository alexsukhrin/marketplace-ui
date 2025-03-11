import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static FlutterSecureStorage? _secureStorage;
  static SharedPreferences? _prefs;
  static const _tokenKey = 'auth_token';

  static Future<void> init() async {
    if (kIsWeb) {
      _prefs = await SharedPreferences.getInstance();
    } else {
      _secureStorage = const FlutterSecureStorage();
    }
  }

  static Future<void> saveToken(String token) async {
    if (kIsWeb) {
      await _prefs?.setString(_tokenKey, token);
    } else {
      await _secureStorage?.write(key: _tokenKey, value: token);
    }
    print('Token saved: $token');
  }

  static Future<String?> getToken() async {
    if (kIsWeb) {
      return _prefs?.getString(_tokenKey);
    } else {
      return await _secureStorage?.read(key: _tokenKey);
    }
  }

  static Future<void> deleteToken() async {
    if (kIsWeb) {
      await _prefs?.remove(_tokenKey);
    } else {
      await _secureStorage?.delete(key: _tokenKey);
    }
  }
}
