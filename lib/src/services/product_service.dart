import 'dart:convert';
import 'package:http/http.dart' as http;

import 'auth_storage.dart';
import '../config/api_config.dart';

class ProductService {
  static Future<List<dynamic>> fetchProducts() async {
    final token = await AuthStorage.getAccessToken();
    final url = Uri.parse(ApiConfig.products);

    // print('📡 Fetching products from $url');
    // print('🔐 Using token: $token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      // print('📊 Response status: ${response.statusCode}');
      // print('📄 Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> products = jsonDecode(response.body);
        print('✅ Products loaded successfully: ${products.length} items');
        return products;
      } else {
        print('❌ Failed to load products: ${response.statusCode}');
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print('🔥 Network error: $e');
      throw Exception('Network error: $e');
    }
  }
}
