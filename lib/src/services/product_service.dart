import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_storage.dart';

class ProductService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  static Future<List<dynamic>> fetchProducts() async {
    final token = await AuthStorage.getToken();
    final url = Uri.parse('$_baseUrl/api/v1/products');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> products =
            jsonDecode(utf8.decode(response.bodyBytes));
        return products;
      } else {
        throw Exception(
            'Failed to load products. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
