import 'package:ai_fitness_app/core/workouts/workout_repository.dart';
import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:flutter/material.dart';

class ResultsViewModel extends ChangeNotifier {
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  final Map<String, String> _queryParams;

  // 1. STATE: The data the UI needs.
  bool _isLoading = true;
  String? _errorMessage;
  List<WorkoutSummary> _workouts = [];

  // 2. GETTERS: How the UI accesses the state.
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<WorkoutSummary> get workouts => _workouts;

  // The ViewModel is initialized with the filter parameters.
  ResultsViewModel(this._queryParams) {
    // Immediately start fetching data when the ViewModel is created.
    fetchFilteredWorkouts();
  }

  // 3. LOGIC: The method to fetch the filtered results.
  Future<void> fetchFilteredWorkouts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Call the repository with the query parameters.
      _workouts = await _workoutRepository.getApiWorkouts(
        queryParams: _queryParams,
      );
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell the UI that loading is complete.
    }
  }
}
