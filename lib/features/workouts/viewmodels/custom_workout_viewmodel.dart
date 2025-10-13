import 'package:ai_fitness_app/core/workouts/workout_repository.dart';
import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:flutter/material.dart';

class CustomWorkoutViewModel extends ChangeNotifier {
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  // 1. STATE
  bool _isLoading = true;
  String? _errorMessage;
  List<WorkoutSummary> _customWorkouts = [];

  // 2. GETTERS
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<WorkoutSummary> get customWorkouts => _customWorkouts;

  // 3. LOGIC

  /// Fetches the list of custom workouts from the local database.
  Future<void> loadCustomWorkouts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _customWorkouts = await _workoutRepository.getCustomWorkouts();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Creates a new custom workout and saves it to the local database.
  Future<void> createWorkout(String name, List<int> exerciseIds) async {
    try {
      // In a real implementation, you'd show a loading indicator here
      await _workoutRepository.createCustomWorkout(name, exerciseIds);
      // After creating, refresh the list to show the new workout
      await loadCustomWorkouts();
    } catch (e) {
      // In a real app, you would show an error message to the user
      _errorMessage = "Failed to create workout: $e";
      notifyListeners();
    }
  }
}
