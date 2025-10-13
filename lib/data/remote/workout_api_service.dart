import 'package:ai_fitness_app/config/api_service.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_card_model.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_detail_model.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_summary_model.dart';

class WorkoutApiService {
  final ApiClient _apiClient = ApiClient();

  /// Fetches a list of workout summaries based on query parameters.
  Future<List<WorkoutSummary>> fetchWorkoutSummary({
    Map<String, String>? queryParams,
  }) async {
    final data =
        await _apiClient.get('workouts/search', queryParams: queryParams)
            as List;
    return data.map((item) => WorkoutSummary.fromJson(item)).toList();
  }

  /// Fetches a list of workout cards based on query parameters.
  Future<List<WorkoutCard>> fetchWorkoutCard({
    Map<String, String>? queryParams,
  }) async {
    final data =
        await _apiClient.get('workouts/search', queryParams: queryParams)
            as List;
    return data.map((item) => WorkoutCard.fromJson(item)).toList();
  }

  /// Fetches the detailed information for a single workout by its ID.
  Future<WorkoutDetail> fetchWorkoutDetail(int workoutId) async {
    final data = await _apiClient.get('workouts/$workoutId');
    return WorkoutDetail.fromJson(data);
  }
}
