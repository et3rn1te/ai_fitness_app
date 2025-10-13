import 'package:ai_fitness_app/core/workouts/workout_repository.dart';
import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:flutter/material.dart';

// The ViewModel holds the state and business logic for the TrainingPage.
class TrainingViewModel extends ChangeNotifier {
  final WorkoutRepository _workoutRepository = WorkoutRepository();

  // 1. STATE: Private variables that hold the UI's data.
  bool _isLoading = true;
  String? _errorMessage;
  List<WorkoutSummary> _featuredWorkouts = [];
  List<WorkoutSummary> _popularWorkouts = [];
  List<WorkoutSummary> _beginnerWorkouts = [];

  // 2. GETTERS: Public ways for the UI to safely access the state.
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<WorkoutSummary> get featuredWorkouts => _featuredWorkouts;
  List<WorkoutSummary> get popularWorkouts => _popularWorkouts;
  List<WorkoutSummary> get beginnerWorkouts => _beginnerWorkouts;

  // 3. LOGIC: A method to fetch all the data for the page.
  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners(); // Tell the UI that we are starting to load.

    try {
      // Use Future.wait to fetch all data in parallel for better performance.
      final results = await Future.wait([
        _workoutRepository.getApiWorkouts(
          queryParams: {'category': 'featured'},
        ), // Fictional param
        _workoutRepository.getApiWorkouts(
          queryParams: {'category': 'popular'},
        ), // Fictional param
        _workoutRepository.getApiWorkouts(queryParams: {'level': 'BEGINNER'}),
      ]);

      // Assign the results to our state variables.
      _featuredWorkouts = results[0];
      _popularWorkouts = results[1];
      _beginnerWorkouts = results[2];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell the UI that loading is complete (either with data or an error).
    }
  }
}
