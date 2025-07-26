import 'package:http/http.dart' as http;
import 'dart:convert';

import '../exceptions/invalid_opt_exception.dart';
import '../exceptions/user_not_found_exception.dart';
import '../config/api_config.dart';

class PasswordResetService {
  static String? _token;

  static Future<Map<String, dynamic>> sendRecoveryEmail(String email) async {
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

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print('Recovery email sent successfully');
        return {
          'success': true,
          'message': responseData['message'] ?? 'Email sent successfully'
        };
      } else if (response.statusCode == 404) {
        throw UserNotFoundException('Користувача з такою поштою не знайдено');
      } else {
        return {
          'success': false,
          'message': responseData['error'] ?? 'Unknown error occurred'
        };
      }
    } catch (e) {
      if (e is UserNotFoundException) {
        rethrow;
      }
      print('Network error: $e');
      throw Exception('Network error');
    }
  }

  static Future<void> validateRecoveryCode(String email, String code) async {
    final url = Uri.parse(ApiConfig.authOtp);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'otp': code,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = responseData['token'];
        print('OTP verified successfully');
      } else if (response.statusCode == 400) {
        if (responseData['error'] == "Invalid OTP.") {
          throw InvalidOtpException('Невірний код підтвердження');
        } else {
          throw Exception('Invalid OTP');
        }
      } else {
        throw Exception('Unknown error occurred');
      }
    } catch (e) {
      if (e is InvalidOtpException) {
        rethrow;
      }
      print('Network error: $e');
      throw Exception('Network error');
    }
  }

  static Future<void> resetPassword(String newPassword) async {
    if (_token == null) {
      throw Exception('No verification token available');
    }

    final url = Uri.parse(ApiConfig.authUpdatePassword);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $_token',
        },
        body: jsonEncode({'new_password': newPassword}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = null; // Clear token after successful password update
        print('Password updated successfully');
      } else {
        throw Exception(responseData['error'] ?? 'Failed to update password');
      }
    } catch (e) {
      print('Network error: $e');
      throw Exception('Network error');
    }
  }
}
