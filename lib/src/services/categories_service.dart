import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_storage.dart';

class CategoryService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  // Utility function to retrieve the JWT token
  static Future<String> getAuthToken() async {
    final token = await AuthStorage.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('JWT token is missing.');
    }
    return token;
  }

  // Fetch product categories
  static Future<List<Map<String, dynamic>>> getCategories() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/categories');
    try {
      // final token = await getAuthToken();

      final response = await http.get(
        url,
        headers: {
          // 'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);

        final categoryList = List<Map<String, dynamic>>.from(
          data['categories'].map((category) => {
                'name': category['name'],
                'category_id': category['category_id'],
                'photo': category['photo'] ?? "",
              }),
        );

        return categoryList;
      } else {
        throw Exception('Failed to fetch categories: ${response.body}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Error fetching categories: $e');
    }
  }

  // Submit selected categories
  static Future<void> submitCategories(
      List<Map<String, dynamic>> categories) async {
    final url = Uri.parse('$_baseUrl/api/v1/users/categories');
    final body = jsonEncode({
      'categories': categories
          .map((category) => {
                // 'name': category['name'],
                'category_id': category['category_id'],
              })
          .toList(),
    });
    print("Submitting categories: $body");

    try {
      final token = await getAuthToken();

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // final responseData = jsonDecode(response.body);
        print('Categories submitted successfully: ${response.body}');
      } else {
        throw Exception(
            'Error submitting categories: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error submitting categories: $e');
      throw Exception('Error submitting categories: $e');
    }
  }
}
