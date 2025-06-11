import 'dart:convert';
import 'package:http/http.dart' as http;

const String _baseUrl =
    'http://ec2-18-197-114-210.eu-central-1.compute.amazonaws.com:8032';

class ShoeSizeOption {
  static Future<List<AdditionalFieldsOptionItem>> getOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/options/shoe-sizes');
    return _fetchOptions(url);
  }
}

class ClothSizeService {
  static Future<List<AdditionalFieldsOptionItem>> getOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/options/clothing-sizes');
    return _fetchOptions(url);
  }
}

class ColorsService {
  static Future<List<AdditionalFieldsOptionItem>> getOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/options/colors');
    return _fetchOptions(url);
  }
}

class GenderService {
  static Future<List<AdditionalFieldsOptionItem>> getOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/options/genders');
    return _fetchOptions(url);
  }
}

class RestOptionsService {
  static Future<Map<String, List<AdditionalFieldsOptionItem>>>
      getAllOptions() async {
    final url = Uri.parse('$_baseUrl/api/v1/products/options/materials');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is Map<String, dynamic>) {
        final Map<String, List<AdditionalFieldsOptionItem>> result = {};

        decoded.forEach((key, value) {
          if (value is List) {
            result[key] = value
                .map((item) => AdditionalFieldsOptionItem.fromJson(item))
                .toList();
          }
        });

        return result;
      } else {
        throw Exception('Unexpected JSON format');
      }
    } else {
      throw Exception('Failed to load options: ${response.statusCode}');
    }
  }
}

class AdditionalFieldsOptionItem {
  final String value;
  final String name;

  AdditionalFieldsOptionItem({required this.value, required this.name});

  factory AdditionalFieldsOptionItem.fromJson(Map<String, dynamic> json) {
    final rawLabel = json['label']?.toString() ?? '';
    String decodedLabel;
    try {
      decodedLabel = utf8.decode(latin1.encode(rawLabel));
    } catch (e) {
      decodedLabel = rawLabel;
    }
    return AdditionalFieldsOptionItem(
      value: json['value'].toString(),
      name: decodedLabel,
    );
  }
}

Future<List<AdditionalFieldsOptionItem>> _fetchOptions(Uri url,
    {String key = 'options'}) async {
  try {
    // print('Fetching options from: $url');
    final response = await http.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      if (decoded is List) {
        return decoded
            .map((item) => AdditionalFieldsOptionItem.fromJson(item))
            .toList();
      }

      if (decoded is Map<String, dynamic>) {
        final List<dynamic> options = decoded[key] ?? decoded['options'];
        return options
            .map((item) => AdditionalFieldsOptionItem.fromJson(item))
            .toList();
      }

      throw Exception('Unexpected JSON format');
    } else {
      throw Exception('Failed to load options');
    }
  } catch (e) {
    throw Exception('Failed to load options: $e');
  }
}
