import 'dart:convert';
import 'package:flutter_application_1/src/services/auth_storage.dart';
import 'package:http/http.dart' as http;

class UserRoleService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  static Future<void> sendRole(Map<String, bool> role) async {
    final token = await AuthStorage.getAccessToken();
    print('Retrieved token: $token');
    if (token == null || token.isEmpty) {
      throw Exception('Authorization token is missing');
    }

    final url = Uri.parse('$_baseUrl/api/v1/users/create');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(role),
      );

      print('Response status: ${response.statusCode}');
      print('Response headers: ${response.headers}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Role sent successfully: $role');
      } else if (response.statusCode == 301 || response.statusCode == 302) {
        print('Redirected to: ${response.headers['location']}');
        throw Exception('Failed to send role: Redirect detected');
      } else {
        throw Exception('Failed to send role');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error');
    }
  }
}
