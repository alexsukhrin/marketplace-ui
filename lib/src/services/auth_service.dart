import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  static const String _baseUrl =
      'http://ec2-54-93-249-171.eu-central-1.compute.amazonaws.com';

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
        print('Користувача зареєстровано: ${response.body}');
      } else {
        print('Помилка реєстрації: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Помилка підключення: $e');
    }
  }
}
