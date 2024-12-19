import 'dart:convert';
import 'package:flutter_application_1/src/services/auth_storage.dart';
import 'package:http/http.dart' as http;

class UserRoleService {
  static const String _baseUrl =
      'http://ec2-3-74-41-70.eu-central-1.compute.amazonaws.com';

  static Future<void> sendRole(Map<String, bool> role) async {
    final token = await AuthStorage.getToken();
    print('Retrieved token: $token');
    if (token == null) {
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
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Role sent successfully: $role');
      } else {
        print('Error sending role: ${response.statusCode}');
        throw Exception('Failed to send role');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error');
    }
  }
}
