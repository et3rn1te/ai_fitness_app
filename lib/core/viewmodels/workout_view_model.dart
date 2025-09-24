import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/core/repositories/workout_repository.dart';
import 'package:flutter/material.dart';

class WorkoutViewModel extends ChangeNotifier {
  final WorkoutRepository _repository;

  WorkoutViewModel(this._repository);

  Stream<List<WorkoutModel>> getFeaturedWorkoutsStream() {
    return _repository.getFeaturedWorkouts();
  }

  Stream<List<WorkoutModel>> getPopularWorkoutsStream() {
    return _repository.getPopularWorkouts();
  }
}
