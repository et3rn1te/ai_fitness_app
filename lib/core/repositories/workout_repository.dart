import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<WorkoutModel>> getFeaturedWorkouts() {
    return _firestore
        .collection('workouts')
        .where('isFeatured', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutModel.fromFirestore(doc))
              .toList();
        });
  }

  Stream<List<WorkoutModel>> getPopularWorkouts() {
    return _firestore
        .collection('workouts')
        .orderBy('popularity', descending: true)
        .limit(6) // Limit to 6 for 2x3 grid
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map((doc) => WorkoutModel.fromFirestore(doc))
              .toList();
        });
  }
}
