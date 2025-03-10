import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
    print('Token saved: $token');
  }

  static Future<String?> getToken() async {
    final token = await _storage.read(key: _tokenKey);
    print('Retrieved token: $token');
    return token;
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    print('Token deleted');
  }
}
