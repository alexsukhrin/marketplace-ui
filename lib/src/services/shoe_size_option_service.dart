import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl =
    'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

class ShoeSizeService {
  static Future<List<ShoeSizeOption>> getShoeSizes() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/options/shoe-sizes');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is List) {
          return decoded.map((item) => ShoeSizeOption.fromJson(item)).toList();
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        throw Exception('Failed to load shoe sizes');
      }
    } catch (e) {
      throw Exception('Error loading shoe sizes: $e');
    }
  }
}

class ShoeSizeOption {
  final int? id;
  final String sizeLabel;

  ShoeSizeOption({this.id, required this.sizeLabel});

  factory ShoeSizeOption.fromJson(Map<String, dynamic> json) {
    return ShoeSizeOption(
      id: json['id'],
      sizeLabel: json['label'] ?? json['name'] ?? '',
    );
  }
}
