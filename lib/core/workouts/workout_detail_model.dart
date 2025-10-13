import 'package:ai_fitness_app/core/workouts/workout_exercise_model.dart';

enum WorkoutLevel { BEGINNER, INTERMEDIATE, ADVANCED, UNKNOWN }

enum ExerciseUnit { REPS, SECONDS, UNKNOWN }

class WorkoutDetail {
  final int id;
  final String title;
  final String? introduction;
  final String imageUrl;
  final int? duration;
  final int? totalExercises;
  final WorkoutLevel level;
  final List<WorkoutExercise> exercises;

  WorkoutDetail({
    required this.id,
    required this.title,
    this.introduction,
    required this.imageUrl,
    this.duration,
    this.totalExercises,
    required this.level,
    required this.exercises,
  });

  factory WorkoutDetail.fromJson(Map<String, dynamic> json) {
    var exerciseList = json['exerciseList'] as List? ?? [];
    List<WorkoutExercise> exercises = exerciseList
        .map((i) => WorkoutExercise.fromJson(i))
        .toList();

    return WorkoutDetail(
      id: json['id'],
      title: json['title'],
      introduction: json['introduction'],
      imageUrl:
          json['imageUrl'] ??
          'https://placehold.co/600x400/cccccc/ffffff?text=Workout',
      duration: json['duration'],
      totalExercises: json['totalExercises'],
      level: WorkoutLevel.values.firstWhere(
        (e) => e.name == json['level'],
        orElse: () => WorkoutLevel.UNKNOWN,
      ),
      exercises: exercises,
    );
  }
}
