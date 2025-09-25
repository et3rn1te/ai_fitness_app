import 'package:ai_fitness_app/core/models/exercise_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutModel {
  final String id;
  final String title;
  final int duration;
  final String level;
  final String imageUrl;
  final String workoutType;
  final bool isFeatured;
  final int popularity;
  final List<ExerciseModel> exercises;

  WorkoutModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.level,
    required this.imageUrl,
    required this.workoutType,
    required this.isFeatured,
    required this.popularity,
    required this.exercises,
  });

  factory WorkoutModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return WorkoutModel(
      id: doc.id,
      title: data['title'] ?? '',
      duration: data['duration'] ?? 0,
      level: data['level'] ?? 'beginner',
      imageUrl: data['imageUrl'] ?? '',
      workoutType: data['workoutType'] ?? '',
      isFeatured: data['isFeatured'] ?? false,
      popularity: data['popularity'] ?? 0,
      exercises: _parseExercises(data['exercises'] ?? []),
    );
  }

  static List<ExerciseModel> _parseExercises(List<dynamic> exercises) {
    return exercises.map((e) => ExerciseModel.fromMap(e)).toList();
  }
}
