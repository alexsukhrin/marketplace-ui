import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  static const String _baseUrl =
      'http://ec2-3-74-41-70.eu-central-1.compute.amazonaws.com';

  // Fetch product categories
  static Future<List<String>> getCategories() async {
    final url =
        Uri.parse('$_baseUrl/api/v1/products/categories'); // Adjusted endpoint
    //   try {
    //     final response = await http.get(url);
    //     print('Response status: ${response.statusCode}');
    //     if (response.statusCode == 200) {
    //       final data = jsonDecode(response.body);
    //       print('Fetched data: $data'); // Print the fetched data
    //       final categoryList = List<String>.from(data['categories']
    //           .map((category) => category['category-id'].toString()));

    //       return categoryList;
    //     } else {
    //       throw Exception('Failed to fetch categories');
    //     }
    //   } catch (e) {
    //     print('Error fetching categories: $e');
    //     throw Exception('Error fetching categories: $e');
    //   }
    // }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken') ?? '';

      if (token.isEmpty) {
        throw Exception('JWT token is missing.');
      }

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Fetched data: $data');
        final categoryList = List<String>.from(data['categories']
            .map((category) => category['category-id'].toString()));
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
  static Future<void> submitCategories(List<String> categories) async {
    final url = Uri.parse('$_baseUrl/api/v1/users/categories');
    final body = jsonEncode({'categories': categories});

//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('authToken');

//       final response = await http.post(
//         url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//         body: body,
//       );
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         print('Категорії: $responseData');
//       } else {
//         print(
//             'Помилка отримання категорій: ${response.statusCode} ${response.body}');
//       }
//     } catch (e) {
//       print('Помилка підключення: $e');
//     }
//   }
// }

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('authToken');

      if (token == null || token.isEmpty) {
        throw Exception('JWT token is missing.');
      }

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Categories submitted successfully: $responseData');
      } else {
        print(
            'Error submitting categories: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error connecting: $e');
      throw Exception('Error connecting: $e');
    }
  }
}
