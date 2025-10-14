import 'package:ai_fitness_app/data/services/workout_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_card_model.dart';

// An enum to represent the different states of our data fetching.
enum ViewState { idle, loading, success, error }

class WorkoutDiscoveryViewModel extends ChangeNotifier {
  final WorkoutApiService _apiService = WorkoutApiService();

  // State for Featured Workouts
  ViewState _featuredState = ViewState.idle;
  List<WorkoutCard> _featuredWorkouts = [];
  ViewState get featuredState => _featuredState;
  List<WorkoutCard> get featuredWorkouts => _featuredWorkouts;

  // State for Popular Workouts
  ViewState _popularState = ViewState.idle;
  List<WorkoutCard> _popularWorkouts = [];
  ViewState get popularState => _popularState;
  List<WorkoutCard> get popularWorkouts => _popularWorkouts;

  // State for Beginner Workouts
  ViewState _beginnerState = ViewState.idle;
  List<WorkoutCard> _beginnerWorkouts = [];
  ViewState get beginnerState => _beginnerState;
  List<WorkoutCard> get beginnerWorkouts => _beginnerWorkouts;

  // General error message
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  WorkoutDiscoveryViewModel() {
    // Fetch all data when the ViewModel is created.
    fetchAllWorkouts();
  }

  Future<void> fetchAllWorkouts() async {
    // Run all fetches in parallel for a faster page load.
    await Future.wait([
      _fetchFeaturedWorkouts(),
      _fetchPopularWorkouts(),
      _fetchBeginnerWorkouts(),
    ]);
  }

  Future<void> _fetchFeaturedWorkouts() async {
    _featuredState = ViewState.loading;
    notifyListeners();
    try {
      _featuredWorkouts = await _apiService.fetchWorkoutCard();
      _featuredState = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _featuredState = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> _fetchPopularWorkouts() async {
    _popularState = ViewState.loading;
    notifyListeners();
    try {
      _popularWorkouts = await _apiService.fetchWorkoutCard();
      _popularState = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _popularState = ViewState.error;
    }
    notifyListeners();
  }

  Future<void> _fetchBeginnerWorkouts() async {
    _beginnerState = ViewState.loading;
    notifyListeners();
    try {
      _beginnerWorkouts = await _apiService.fetchWorkoutCard();
      _beginnerState = ViewState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _beginnerState = ViewState.error;
    }
    notifyListeners();
  }
}
