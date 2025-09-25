import 'package:ai_fitness_app/core/models/body_part_model.dart';
import 'package:ai_fitness_app/core/models/workout_type_model.dart';
import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<WorkoutTypeModel>> getWorkoutTypes() {
    return _firestore
        .collection('workout_types')
        .orderBy('order')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutTypeModel.fromFirestore(doc))
              .toList();
        });
  }

  Stream<List<BodyPartModel>> getBodyParts() {
    return _firestore.collection('body_parts').orderBy('order').snapshots().map(
      (snapshot) {
        return snapshot.docs
            .map((doc) => BodyPartModel.fromFirestore(doc))
            .toList();
      },
    );
  }

  Future<List<WorkoutModel>> getWorkoutsByType(String workoutTypeName) {
    return _firestore
        .collection('workouts')
        .where('workoutType', isEqualTo: workoutTypeName)
        .get()
        .then((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<List<WorkoutModel>> getWorkoutsByBodyPart(String bodyPartName) {
    return _firestore
        .collection('workouts')
        .where('bodyPart', isEqualTo: bodyPartName)
        .get()
        .then((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<List<WorkoutModel>> getWorkoutsByLevel(String levelName) {
    return _firestore
        .collection('workouts')
        .where('level', isEqualTo: levelName)
        .get()
        .then((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutModel.fromFirestore(doc))
              .toList();
        });
  }

  Future<List<WorkoutModel>> getWorkoutsByDuration(
    int minDuration,
    int maxDuration,
  ) async {
    final querySnapshot = await _firestore
        .collection('workouts')
        .where('duration', isGreaterThanOrEqualTo: minDuration)
        .where('duration', isLessThanOrEqualTo: maxDuration)
        .get();

    return querySnapshot.docs
        .map((doc) => WorkoutModel.fromFirestore(doc))
        .toList();
  }

  Future<List<WorkoutModel>> getWorkoutsLessThan(int duration) async {
    final querySnapshot = await _firestore
        .collection('workouts')
        .where('duration', isLessThan: duration)
        .get();

    return querySnapshot.docs
        .map((doc) => WorkoutModel.fromFirestore(doc))
        .toList();
  }

  Future<List<WorkoutModel>> getWorkoutsMoreThan(int duration) async {
    final querySnapshot = await _firestore
        .collection('workouts')
        .where('duration', isGreaterThan: duration)
        .get();

    return querySnapshot.docs
        .map((doc) => WorkoutModel.fromFirestore(doc))
        .toList();
  }
}
