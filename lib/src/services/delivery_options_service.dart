import 'dart:convert';
import 'package:http/http.dart' as http;

class DeliveryOptionService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  static Future<List<DeliveryOption>> getDeliveryOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/delivery-options');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> deliveryOptions = data['delivery_options'];

        return deliveryOptions
            .map((item) => DeliveryOption.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load delivery options');
      }
    } catch (e) {
      throw Exception('Error during HTTP request: $e');
    }
  }
}

class DeliveryOption {
  final int id;
  final String name;

  DeliveryOption({
    required this.id,
    required this.name,
  });

  factory DeliveryOption.fromJson(Map<String, dynamic> json) {
    return DeliveryOption(
      id: json['id'],
      name: json['name'],
    );
  }
}
