import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config/api_config.dart';

class AdditionalFieldsService {
  static Future<List<dynamic>> fetchShoeSizes() async {
    final url = Uri.parse(ApiConfig.shoeSizes);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load shoe sizes');
  }

  static Future<List<dynamic>> fetchClothingSizes() async {
    final url = Uri.parse(ApiConfig.clothingSizes);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load clothing sizes');
  }

  static Future<List<dynamic>> fetchColors() async {
    final url = Uri.parse(ApiConfig.colors);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load colors');
  }

  static Future<List<dynamic>> fetchGenders() async {
    final url = Uri.parse(ApiConfig.genders);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load genders');
  }

  static Future<List<dynamic>> fetchMaterials() async {
    final url = Uri.parse(ApiConfig.materials);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load materials');
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
