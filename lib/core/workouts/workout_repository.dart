import 'package:ai_fitness_app/core/api/workout_api_service.dart';
import 'package:ai_fitness_app/core/utils/database_helper.dart';
import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';

// This repository is the single source of truth for workout data for the UI.
class WorkoutRepository {
  final WorkoutApiService _apiService = WorkoutApiService();
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // --- REMOTE DATA ---
  // Fetches standard workouts from the server
  Future<List<WorkoutSummary>> getApiWorkouts({
    Map<String, String>? queryParams,
  }) {
    return _apiService.fetchWorkoutSummary(queryParams: queryParams);
  }

  // --- LOCAL DATA ---
  // Fetches user-created workouts from the local SQLite database
  Future<List<WorkoutSummary>> getCustomWorkouts() async {
    final workoutMaps = await _dbHelper.getCustomWorkouts();

    // Convert the database map into the WorkoutSummary model your UI expects
    return workoutMaps.map((map) {
      return WorkoutSummary(
        id: map['id'],
        title: map['name'],
        duration: map['durationMinutes'],
        level: WorkoutLevel.UNKNOWN, // Local workouts might not have a level
        imageUrl:
            map['imageUrl'] ??
            'https://placehold.co/400x300/2d3748/ffffff?text=Custom',
        isCustom: true, // This is key
        // You would need another DB query to get the exercise count
        totalExercises: 0,
      );
    }).toList();
  }

  // In the future, a method to create a custom workout would look like this:
  Future<void> createCustomWorkout(String name, List<int> exerciseIds) async {
    // 1. Call the database helper to insert the data locally
    await _dbHelper.createCustomWorkout(name);
    // ... and insert the exercises into the custom_workout_exercises table
  }
}
