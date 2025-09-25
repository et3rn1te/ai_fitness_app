// core/models/exercise_model.dart
class ExerciseModel {
  final String name;
  final String? duration; // For time-based exercises
  final int? reps; // For rep-based exercises
  final String animationUrl;
  final String? bodyPart;

  ExerciseModel({
    required this.name,
    this.duration,
    this.reps,
    required this.animationUrl,
    this.bodyPart,
  });

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      name: map['name'] ?? '',
      duration: map['duration'],
      reps: map['reps'],
      animationUrl: map['animationUrl'] ?? '',
      bodyPart: map['bodyPart'],
    );
  }

  String get count {
    if (duration != null) return duration!;
    if (reps != null) return 'x$reps';
    return '';
  }
}
