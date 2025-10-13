import 'package:ai_fitness_app/core/api/category_api_service.dart';
import 'package:ai_fitness_app/core/categories/body_part_model.dart';
import 'package:ai_fitness_app/core/categories/category_model.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryApiService _apiService = CategoryApiService();

  // 1. STATE: The data for all the filter sections.
  bool _isLoading = true;
  String? _errorMessage;
  List<BodyPart> _bodyParts = [];
  List<Category> _workoutTypes = [];
  // You can add lists for Equipment, etc. here later.

  // 2. GETTERS: How the UI will access the state.
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<BodyPart> get bodyParts => _bodyParts;
  List<Category> get workoutTypes => _workoutTypes;

  // 3. LOGIC: Fetch all necessary data for the page.
  Future<void> loadCategories() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Fetch data for all sections in parallel.
      final results = await Future.wait([
        _apiService.fetchBodyPartsWithImage(),
        _apiService.fetchWorkoutTypes(),
      ]);

      _bodyParts = results[0] as List<BodyPart>;
      _workoutTypes = results[1] as List<Category>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // Tell the UI that loading is complete.
    }
  }
}
