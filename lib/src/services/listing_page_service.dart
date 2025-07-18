import 'package:flutter/material.dart';

import 'auth_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

class ListingPageService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  static Future<void> createProduct({
    required String title,
    required String description,
    required String category,
    required String brand,
    required String condition,
    required double price,
    required String phoneNumber,
    required String deliveryOption,
    required String paymentOption,
    required List<Uint8List> images,
    required BuildContext context,
    String? color,
    String? material,
    String? gender,
    String? clothingSize,
    String? shoeSize,
    String? bookBinding,
    String? bookLanguages,
    String? bookGenre,
    String? clothingMaterials,
    String? shoeMaterials,
    String? homeMaterials,
    String? homeTypes,
    String? electronisTypes,
    String? autoTypes,
    String? stationeryTypes,
    String? activityTypes,
    String? waterSportsTypes,
    String? cyclingTypes,
    String? childrenTypes,
    String? gardenTypes,
  }) async {
    try {
      final token = await AuthStorage.getAccessToken();

      var uri = Uri.parse('$_baseUrl/api/v1/products/create');
      var request = http.MultipartRequest('POST', uri);

      // текстові поля
      request.fields['title'] = title;
      request.fields['description'] = description;
      request.fields['category_id'] = category;
      request.fields['brand'] = brand;
      request.fields['condition'] = condition;
      request.fields['price'] = price.toString();
      request.fields['phone_number'] = phoneNumber;
      request.fields['delivery_option'] = deliveryOption;
      request.fields['payment_option'] = paymentOption;

      // Необов’язкові поля
      if (color != null && color.isNotEmpty) {
        request.fields['color'] = color;
      }
      if (material != null && material.isNotEmpty) {
        request.fields['material'] = material;
      }
      if (gender != null && gender.isNotEmpty) {
        request.fields['gender'] = gender;
      }
      if (clothingSize != null && clothingSize.isNotEmpty) {
        request.fields['clothing_size'] = clothingSize;
      }
      if (shoeSize != null && shoeSize.isNotEmpty) {
        request.fields['shoe_size'] = shoeSize;
      }
      if (bookBinding != null && bookBinding.isNotEmpty) {
        request.fields['book_binding'] = bookBinding;
      }
      if (bookLanguages != null && bookLanguages.isNotEmpty) {
        request.fields['book_languages'] = bookLanguages;
      }
      if (bookGenre != null && bookGenre.isNotEmpty) {
        request.fields['book_genres'] = bookGenre;
      }

      // файли
      for (int i = 0; i < images.length; i++) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'photos',
            images[i],
            filename: 'photo_$i.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      }

      request.headers['Authorization'] = 'Bearer $token';
      // print('Attached files: ${request.files.map((f) => f.filename).toList()}');
      print('🔵 Sending request to: $uri');
      print('🔵 Request fields: ${request.fields}');
      print('🔵 Request headers: ${request.headers}');

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print('🟣 Response status: ${response.statusCode}');
      print('🟣 Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        _showPopup(context, 'Продукт відправлений на модерацію');
      } else {
        _showPopup(context, 'Помилка додавання продукту: ${response.body}');
        print('Error body: ${response.body}');
      }
    } catch (e) {
      _showPopup(context, 'Помилка при відправці даних');
      print('Error sending product data: $e');
    }
  }

  static void _showPopup(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
