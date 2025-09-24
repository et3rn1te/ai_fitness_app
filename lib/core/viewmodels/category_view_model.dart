import 'package:ai_fitness_app/core/models/body_part_model.dart';
import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/core/models/workout_type_model.dart';
import 'package:ai_fitness_app/core/repositories/category_repository.dart';
import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryRepository _repository;

  CategoryViewModel(this._repository);

  Stream<List<WorkoutTypeModel>> getWorkoutTypesStream() {
    return _repository.getWorkoutTypes();
  }

  Stream<List<BodyPartModel>> getBodyPartsStream() {
    return _repository.getBodyParts();
  }

  Future<List<WorkoutModel>> getWorkoutsByType(String workoutTypeId) {
    return _repository.getWorkoutsByType(workoutTypeId);
  }
}
