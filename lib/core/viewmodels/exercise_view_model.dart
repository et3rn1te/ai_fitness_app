import 'package:ai_fitness_app/core/models/exercise_model.dart';
import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:flutter/material.dart';

class ExerciseViewModel extends ChangeNotifier {
  final WorkoutModel workout;

  ExerciseViewModel(this.workout);

  List<ExerciseModel> get exercises => workout.exercises;
  String get workoutTitle => workout.title;
  int get workoutDuration => workout.duration;
  String get workoutLevel => workout.level;
  String get workoutImage => workout.imageUrl;
}
