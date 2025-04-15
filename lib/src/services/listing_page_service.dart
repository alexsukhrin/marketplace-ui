import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProductService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  // Метод для відправки продукту на сервер
  static Future<void> createProduct(
      Map<String, dynamic> productData, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/products'), // URL для створення продукту
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer YOUR_AUTH_TOKEN', // Якщо потрібна авторизація
        },
        body: json.encode(productData), // Перетворюємо дані на JSON
      );

      if (response.statusCode == 201) {
        // Продукт успішно додано
        _showPopup(context, 'Продукт відправлений на модерацію');
      } else {
        // Якщо сталася помилка на сервері
        _showPopup(context, 'Помилка додавання продукту');
      }
    } catch (e) {
      // Якщо сталася помилка при підключенні до сервера
      _showPopup(context, 'Помилка при відправці даних');
      print('Error sending product data: $e');
    }
  }

  // Метод для показу вспливаючого вікна
  static void _showPopup(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
