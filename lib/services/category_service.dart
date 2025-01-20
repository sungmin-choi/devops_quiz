import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:devops_quiz/models/category.dart';

class CategoryService {
  static const String baseUrl = 'http://192.168.0.37:3000'; // 실제 API URL로 변경

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
