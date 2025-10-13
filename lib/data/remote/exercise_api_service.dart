import 'package:ai_fitness_app/config/api_service.dart';
import 'package:ai_fitness_app/data/models/exercises/exercise_summary_model.dart';

class ExerciseApiService {
  final ApiClient _apiClient = ApiClient();

  /// Fetches a list of all exercises.
  Future<List<ExerciseSummary>> fetchAllExercises() async {
    final data = await _apiClient.get('exercises') as List;
    return data.map((item) => ExerciseSummary.fromJson(item)).toList();
  }

  /// Searches for exercises based on a map of query parameters.
  Future<List<ExerciseSummary>> searchExercises(
    Map<String, String> queryParams,
  ) async {
    final data =
        await _apiClient.get('exercises/search', queryParams: queryParams)
            as List;
    return data.map((item) => ExerciseSummary.fromJson(item)).toList();
  }
}
