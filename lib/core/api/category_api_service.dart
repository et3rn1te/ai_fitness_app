import 'dart:convert';
import 'package:ai_fitness_app/core/categories/body_part_model.dart';
import 'package:ai_fitness_app/core/categories/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryApiService {
  final String _baseUrl = "http://10.0.2.2:8080/api";

  Future<List<T>> _fetchCategories<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final uri = Uri.parse('$_baseUrl/categories/$endpoint');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final json = jsonDecode(utf8.decode(response.bodyBytes));
      if (json['success'] == true) {
        final List<dynamic> data = json['data'] ?? [];
        return data.map((item) => fromJson(item)).toList();
      }
    }
    throw Exception('Failed to load categories from $endpoint');
  }

  Future<List<BodyPart>> fetchBodyPartsWithImage() =>
      _fetchCategories('body-parts', BodyPart.fromJson);
  Future<List<Category>> fetchBodyPartCategories() =>
      _fetchCategories('body-parts/simple', Category.fromJson);
  Future<List<Category>> fetchWorkoutTypes() =>
      _fetchCategories('workout-types', Category.fromJson);
  Future<List<Category>> fetchExerciseTypes() =>
      _fetchCategories('exercise-types', Category.fromJson);
  Future<List<Category>> fetchEquipment() =>
      _fetchCategories('equipments', Category.fromJson);
}
