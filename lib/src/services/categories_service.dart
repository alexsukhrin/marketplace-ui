import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_storage.dart';
import '../config/api_config.dart';

class CategoryService {
  // Utility function to retrieve the JWT token
  static Future<String> getAuthToken() async {
    final token = await AuthStorage.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('JWT token is missing.');
    }
    return token;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final url = Uri.parse(ApiConfig.productsCategories);

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

             if (response.statusCode == 200) {
         final List<dynamic> categories = jsonDecode(response.body);
         print('Categories fetched successfully: $categories');
         return List<Map<String, dynamic>>.from(categories);
      } else {
        print('Failed to fetch categories: ${response.statusCode}');
        throw Exception('Failed to fetch categories');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      throw Exception('Network error while fetching categories');
    }
  }

  static Future<void> submitCategories(
      List<Map<String, dynamic>> categoriesRequest) async {
    try {
      final token = await getAuthToken();

      final url = Uri.parse(ApiConfig.usersCategories);

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "categories": categoriesRequest,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Categories updated successfully');
      } else {
        print('Failed to update categories: ${response.statusCode}');
        throw Exception('Failed to update categories');
      }
    } catch (e) {
      print('Error updating categories: $e');
      throw Exception('Network error while updating categories');
    }
  }

  static Future<List<dynamic>> getUserInterests() async {
    try {
      final token = await getAuthToken();

      final url = Uri.parse(ApiConfig.usersCategories);

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData['categories'] ?? [];
      } else {
        print('Failed to get user interests: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error getting user interests: $e');
      return [];
    }
  }
}
