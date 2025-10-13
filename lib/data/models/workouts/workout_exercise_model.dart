enum ExerciseUnit { REPS, SECONDS, UNKNOWN }

class WorkoutExercise {
  final String exerciseTitle;
  final String? exerciseAnimationUrl;
  final ExerciseUnit unit;
  final int value;

  WorkoutExercise({
    required this.exerciseTitle,
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
      exerciseTitle: json['exerciseTitle'],
      exerciseAnimationUrl: json['exerciseAnimationUrl'],
      unit: ExerciseUnit.values.firstWhere(
        (e) => e.name == json['unit'],
        orElse: () => ExerciseUnit.UNKNOWN,
      ),
      value: json['value'],
    );
  }
}
