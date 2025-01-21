import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devops_quiz/models/category.dart';
import 'package:devops_quiz/config/app_config.dart';

class CategoryService {
  static const String baseUrl = AppConfig.baseUrl; // 실제 API URL로 변경

  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories'));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
