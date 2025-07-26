import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class PaymentService {
  static Future<List<dynamic>> fetchPaymentOptions() async {
    final url = Uri.parse(ApiConfig.paymentOptions);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load payment options');
  }

  static Future<List<dynamic>> fetchDeliveryOptions() async {
    final url = Uri.parse(ApiConfig.deliveryOptions);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load delivery options');
  }
}
