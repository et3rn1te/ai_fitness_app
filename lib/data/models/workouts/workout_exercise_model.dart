enum ExerciseUnit { REPS, SECONDS, UNKNOWN }

class WorkoutExercise {
  final int exerciseId;
  final String exerciseTitle;
  final String instructions;
  final String? exerciseAnimationUrl;
  final ExerciseUnit unit;
  final int value;

  WorkoutExercise({
    required this.exerciseId,
    required this.exerciseTitle,
    required this.instructions,
    this.exerciseAnimationUrl,
    required this.unit,
    required this.value,
  });

  // Helper getter to format the count string for the UI
  String get displayCount {
    if (unit == ExerciseUnit.REPS) {
      return 'x$value';
    } else if (unit == ExerciseUnit.SECONDS) {
      return '${value}s';
    }
    return '$value';
  }

  factory WorkoutExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutExercise(
      exerciseId: json['exerciseId'],
      exerciseTitle: json['exerciseTitle'],
      instructions: json['instructions'],
      exerciseAnimationUrl: json['exerciseAnimationUrl'],
      unit: ExerciseUnit.values.firstWhere(
        (e) => e.name == json['unit'],
        orElse: () => ExerciseUnit.UNKNOWN,
      ),
      value: json['value'],
    );
  }
}
