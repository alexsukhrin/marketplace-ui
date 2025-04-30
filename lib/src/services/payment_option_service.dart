import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentOptionService {
  static const String _baseUrl =
      'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

  static Future<List<PaymentOption>> getPaymentOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/payment-options');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          final List<dynamic> paymentOptions = data['payment_options'];

          return paymentOptions
              .map((item) => PaymentOption.fromJson(item))
              .toList();
        } catch (e) {
          throw Exception('Failed to decode JSON');
        }
      } else {
        throw Exception('Failed to load payment options');
      }
    } catch (e) {
      throw Exception('Failed to load payment options');
    }
  }
}

class PaymentOption {
  final int id;
  final String name;

  PaymentOption({
    required this.id,
    required this.name,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      id: json['id'],
      name: json['name'],
    );
  }
}
