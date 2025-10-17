import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: [BodyParts, Equipment, ExerciseTypes, WorkoutTypes, Exercises, Workouts, WorkoutExercises])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Add migration logic here when needed
      },
    );
  }

  // Body Parts Operations
  Future<List<BodyPartData>> getAllBodyParts() => select(bodyParts).get();
  Future<BodyPartData> getBodyPartById(int id) =>
      (select(bodyParts)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertBodyPart(BodyPartsCompanion bodyPart) =>
      into(bodyParts).insert(bodyPart);
  Future<bool> updateBodyPart(BodyPartsCompanion bodyPart) =>
      update(bodyParts).replace(bodyPart);
  Future<int> deleteBodyPart(int id) =>
      (delete(bodyParts)..where((t) => t.id.equals(id))).go();

  // Equipment Operations
  Future<List<EquipmentData>> getAllEquipment() => select(equipment).get();
  Future<EquipmentData> getEquipmentById(int id) =>
      (select(equipment)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertEquipment(EquipmentCompanion equipment) =>
      into(this.equipment).insert(equipment);
  Future<bool> updateEquipment(EquipmentCompanion equipment) =>
      update(this.equipment).replace(equipment);
  Future<int> deleteEquipment(int id) =>
      (delete(this.equipment)..where((t) => t.id.equals(id))).go();

  // Exercise Types Operations
  Future<List<ExerciseTypeData>> getAllExerciseTypes() =>
      select(exerciseTypes).get();
  Future<ExerciseTypeData> getExerciseTypeById(int id) =>
      (select(exerciseTypes)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertExerciseType(ExerciseTypesCompanion exerciseType) =>
      into(exerciseTypes).insert(exerciseType);
  Future<bool> updateExerciseType(ExerciseTypesCompanion exerciseType) =>
      update(exerciseTypes).replace(exerciseType);
  Future<int> deleteExerciseType(int id) =>
      (delete(exerciseTypes)..where((t) => t.id.equals(id))).go();

  // Workout Types Operations
  Future<List<WorkoutTypeData>> getAllWorkoutTypes() =>
      select(workoutTypes).get();
  Future<WorkoutTypeData> getWorkoutTypeById(int id) =>
      (select(workoutTypes)..where((t) => t.id.equals(id))).getSingle();
  Future<int> insertWorkoutType(WorkoutTypesCompanion workoutType) =>
      into(workoutTypes).insert(workoutType);
  Future<bool> updateWorkoutType(WorkoutTypesCompanion workoutType) =>
      update(workoutTypes).replace(workoutType);
  Future<int> deleteWorkoutType(int id) =>
      (delete(workoutTypes)..where((t) => t.id.equals(id))).go();

  // Exercise Operations
  Future<List<ExerciseData>> getAllExercises() => select(exercises).get();
  
  Future<ExerciseData> getExerciseById(int id) =>
      (select(exercises)..where((t) => t.id.equals(id))).getSingle();
  
  Future<List<ExerciseData>> getExercisesByBodyPart(int bodyPartId) =>
      (select(exercises)..where((t) => t.bodyPartId.equals(bodyPartId))).get();
  
  Future<List<ExerciseData>> getExercisesByType(int typeId) =>
      (select(exercises)..where((t) => t.exerciseTypeId.equals(typeId))).get();
  
  Future<List<ExerciseData>> getExercisesByEquipment(int equipmentId) =>
      (select(exercises)..where((t) => t.equipmentId.equals(equipmentId))).get();
  
  Future<List<ExerciseData>> getExercisesByDifficulty(ExerciseDifficulty difficulty) =>
      (select(exercises)..where((t) => t.difficulty.equals(difficulty.name))).get();
  
  Future<int> insertExercise(ExercisesCompanion exercise) =>
      into(exercises).insert(exercise);
  
  Future<bool> updateExercise(ExercisesCompanion exercise) =>
      update(exercises).replace(exercise);
  
  Future<int> deleteExercise(int id) =>
      (delete(exercises)..where((t) => t.id.equals(id))).go();

  // Workout Operations
  Future<List<WorkoutData>> getAllWorkouts() => select(workouts).get();
  
  Future<WorkoutData> getWorkoutById(int id) =>
      (select(workouts)..where((t) => t.id.equals(id))).getSingle();
  
  Future<List<WorkoutData>> getWorkoutsByBodyPart(int bodyPartId) =>
      (select(workouts)..where((t) => t.bodyPartId.equals(bodyPartId))).get();
  
  Future<List<WorkoutData>> getWorkoutsByType(int typeId) =>
      (select(workouts)..where((t) => t.workoutTypeId.equals(typeId))).get();
  
  Future<List<WorkoutData>> getWorkoutsByLevel(WorkoutLevel level) =>
      (select(workouts)..where((t) => t.level.equals(level.name))).get();
  
  Future<List<WorkoutData>> getCustomWorkouts() =>
      (select(workouts)..where((t) => t.isCustom.equals(true))).get();
  
  Future<int> insertWorkout(WorkoutsCompanion workout) =>
      into(workouts).insert(workout);
  
  Future<bool> updateWorkout(WorkoutsCompanion workout) =>
      update(workouts).replace(workout);
  
  Future<int> deleteWorkout(int id) =>
      (delete(workouts)..where((t) => t.id.equals(id))).go();

  // Workout Exercise Operations
  Future<List<WorkoutExerciseData>> getWorkoutExercises(int workoutId) =>
      (select(workoutExercises)
        ..where((t) => t.workoutId.equals(workoutId))
        ..orderBy([(t) => OrderingTerm(expression: t.order)]))
      .get();
  
  Future<int> insertWorkoutExercise(WorkoutExercisesCompanion workoutExercise) =>
      into(workoutExercises).insert(workoutExercise);
  
  Future<bool> updateWorkoutExercise(WorkoutExercisesCompanion workoutExercise) =>
      update(workoutExercises).replace(workoutExercise);
  
  Future<int> deleteWorkoutExercise(int id) =>
      (delete(workoutExercises)..where((t) => t.id.equals(id))).go();
  
  Future<int> deleteWorkoutExercises(int workoutId) =>
      (delete(workoutExercises)..where((t) => t.workoutId.equals(workoutId))).go();

  // Transaction to insert workout with its exercises
  Future<int> insertWorkoutWithExercises(
    WorkoutsCompanion workout,
    List<WorkoutExercisesCompanion> exercises,
  ) {
    return transaction(() async {
      final workoutId = await into(workouts).insert(workout);
      
      for (final exercise in exercises) {
        await into(workoutExercises).insert(
          exercise.copyWith(workoutId: Value(workoutId)),
        );
      }
      
      return workoutId;
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
