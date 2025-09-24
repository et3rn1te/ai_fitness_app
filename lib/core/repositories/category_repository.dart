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

  Future<List<WorkoutModel>> getWorkoutsByType(String workoutTypeId) {
    return _firestore
        .collection('workouts')
        .where('workoutType', isEqualTo: workoutTypeId)
        .get()
        .then((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutModel.fromFirestore(doc))
              .toList();
        });
  }
}
