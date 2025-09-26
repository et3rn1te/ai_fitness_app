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

  Future<List<WorkoutModel>> searchWorkouts(String query) async {
    // Convert query to lowercase for case-insensitive search
    query = query.toLowerCase();

    final querySnapshot = await _firestore.collection('workouts').get();

    // Filter workouts locally since Firestore doesn't support case-insensitive search
    return querySnapshot.docs
        .map((doc) => WorkoutModel.fromFirestore(doc))
        .where(
          (workout) =>
              workout.title.toLowerCase().contains(query) ||
              workout.workoutType.toLowerCase().contains(query) ||
              workout.level.toLowerCase().contains(query),
        )
        .toList();
  }
}
