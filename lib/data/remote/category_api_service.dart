import 'package:ai_fitness_app/config/api_service.dart';
import 'package:ai_fitness_app/data/models/categories/body_part_model.dart';
import 'package:ai_fitness_app/data/models/categories/category_model.dart';

class CategoryApiService {
  final ApiClient _apiClient = ApiClient();

  Future<List<T>> _fetchCategoryList<T>(
    String endpoint,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final data = await _apiClient.get('categories/$endpoint') as List;
    return data.map((item) => fromJson(item)).toList();
  }

  /// Fetches a list of body parts with their associated images.
  Future<List<BodyPart>> fetchBodyPartsWithImage() =>
      _fetchCategoryList('body-parts', BodyPart.fromJson);

  /// Fetches a simplified list of body part categories.
  Future<List<Category>> fetchBodyPartCategories() =>
      _fetchCategoryList('body-parts/simple', Category.fromJson);

  /// Fetches a list of available workout types.
  Future<List<Category>> fetchWorkoutTypes() =>
      _fetchCategoryList('workout-types', Category.fromJson);

  /// Fetches a list of available exercise types.
  Future<List<Category>> fetchExerciseTypes() =>
      _fetchCategoryList('exercise-types', Category.fromJson);

  /// Fetches a list of available equipment.
  Future<List<Category>> fetchEquipment() =>
      _fetchCategoryList('equipments', Category.fromJson);
}
