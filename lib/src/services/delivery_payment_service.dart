import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl =
    'http://ec2-18-153-92-5.eu-central-1.compute.amazonaws.com:8032';

class PaymentOptionService {
  static Future<List<OptionItem>> getOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/payment-options');
    return _fetchOptions(url, key: 'payment_options');
  }
}

class DeliveryOptionService {
  static Future<List<OptionItem>> getOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/delivery-options');
    return _fetchOptions(url, key: 'delivery_options');
  }
}

Future<List<OptionItem>> _fetchOptions(Uri url,
    {String key = 'options'}) async {
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded.map((item) => OptionItem.fromJson(item)).toList();
      }

      if (decoded is Map<String, dynamic>) {
        final List<dynamic> options = decoded[key] ?? decoded['options'];
        return options.map((item) => OptionItem.fromJson(item)).toList();
      }

      throw Exception('Unexpected JSON format');
    } else {
      throw Exception('Failed to load options');
    }
  } catch (e) {
    throw Exception('Failed to load options: $e');
  }
}

class OptionItem {
  final int id;
  final String name;

  OptionItem({required this.id, required this.name});

  factory OptionItem.fromJson(Map<String, dynamic> json) {
    return OptionItem(
      id: json['id'],
      name: json['name'],
    );
  }
}
