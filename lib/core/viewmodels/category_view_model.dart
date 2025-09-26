import 'package:ai_fitness_app/core/models/body_part_model.dart';
import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/core/models/workout_type_model.dart';
import 'package:ai_fitness_app/core/repositories/category_repository.dart';
import 'package:ai_fitness_app/core/repositories/workout_repository.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  bool isLoading = false;

  CategoryViewModel(this._repository);

  Stream<List<WorkoutTypeModel>> getWorkoutTypesStream() {
    return _repository.getWorkoutTypes();
  }

  Stream<List<BodyPartModel>> getBodyPartsStream() {
    return _repository.getBodyParts();
  }

  Future<List<WorkoutModel>> getWorkoutsByType(String workoutTypeName) {
    return _repository.getWorkoutsByType(workoutTypeName);
  }

  Future<List<WorkoutModel>> getWorkoutsByBodyPart(String bodyPartName) {
    return _repository.getWorkoutsByBodyPart(bodyPartName);
  }

  Future<List<WorkoutModel>> getWorkoutsByLevel(String levelName) {
    return _repository.getWorkoutsByLevel(levelName);
  }

  Future<List<WorkoutModel>> getWorkoutsByDuration(String duration) async {
    switch (duration) {
      case '<4':
        return _repository.getWorkoutsLessThan(4);
      case '5-7':
        return _repository.getWorkoutsByDuration(5, 7);
      case '8-10':
        return _repository.getWorkoutsByDuration(8, 10);
      default:
        return _repository.getWorkoutsMoreThan(10);
    }
  }

  Future<List<WorkoutModel>> searchWorkouts(String query) async {
    try {
      isLoading = true;
      notifyListeners();

      final results = await _workoutRepository.searchWorkouts(query);

      isLoading = false;
      notifyListeners();

      return results;
    } catch (e) {
      isLoading = false;
      notifyListeners();
      rethrow;
    }
  }
}
