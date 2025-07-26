import 'dart:convert';
import 'dart:io';
import 'package:flutter_application_1/src/services/auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../config/api_config.dart';

class ListingPageService {
  static Future<bool> createProduct(
    Map<String, dynamic> productData,
    List<File> images,
  ) async {
    try {
      final token = await AuthStorage.getAccessToken();

      if (token == null) {
        print('🔐 No auth token found');
        return false;
      }

      print('📦 Creating product with data: $productData');
      print('🖼️ Number of images: ${images.length}');

      // Convert productData to the exact format expected by the API
      final List<Map<String, dynamic>> productDataList = [
        {
          'name': productData['name'],
          'description': productData['description'],
          'price': productData['price'].toString(),
          'category': productData['category'],
          'condition': productData['condition'],
          'brand': productData['brand'],
          'size': productData['size'],
          'color': productData['color'],
          'material': productData['material'],
          'gender': productData['gender'],
          'delivery_method': productData['delivery_method'],
          'payment_method': productData['payment_method'],
        }
      ];

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ApiConfig.productsCreate),
      );

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['products'] = jsonEncode(productDataList);

      // Add images
      for (int i = 0; i < images.length; i++) {
        if (kIsWeb) {
          // For web, read bytes and add as MultipartFile
          final bytes = await images[i].readAsBytes();
          request.files.add(
            http.MultipartFile.fromBytes(
              'images',
              bytes,
              filename: 'image_$i.jpg',
            ),
          );
        } else {
          // For mobile platforms
          request.files.add(
            await http.MultipartFile.fromPath(
              'images',
              images[i].path,
            ),
          );
        }
      }

      print('🚀 Sending request to: ${request.url}');
      print('📋 Request fields: ${request.fields}');
      print(
          '🖼️ Request files: ${request.files.map((f) => f.filename).toList()}');

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print('📨 Response status: ${response.statusCode}');
      print('📄 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Product created successfully');
        return true;
      } else {
        print('❌ Failed to create product: ${response.statusCode}');
        print('Error details: ${response.body}');
        return false;
      }
    } catch (e) {
      print('🔥 Error creating product: $e');
      return false;
    }
  }
}
