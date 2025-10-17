import 'package:drift/drift.dart';
import 'workouts.dart';
import 'exercises.dart';
import 'enums.dart';

@DataClassName('WorkoutExerciseData')
class WorkoutExercises extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Foreign keys
  IntColumn get workoutId => integer().references(Workouts, #id)();
  IntColumn get exerciseId => integer().references(Exercises, #id)();

  IntColumn get order => integer()();
  TextColumn get unit => textEnum<ExerciseUnit>()();
  IntColumn get value => integer()(); // count for reps or seconds
  IntColumn get reps => integer()();
}
