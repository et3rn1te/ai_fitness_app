enum WorkoutLevel { BEGINNER, INTERMEDIATE, ADVANCED, UNKNOWN }

class WorkoutSummary {
  final int id;
  final String imageUrl;
  final String title;
  final int? duration;
  final int? totalExercises;
  final WorkoutLevel level;
  final bool isCustom;

  WorkoutSummary({
    required this.id,
    required this.title,
    this.duration,
    this.totalExercises,
    required this.level,
    required this.imageUrl,
    this.isCustom = false,
  });

  factory WorkoutSummary.fromJson(Map<String, dynamic> json) {
    return WorkoutSummary(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      totalExercises: json['totalExercises'],
      level: WorkoutLevel.values.firstWhere(
        (e) => e.toString().split('.').last == json['level'],
        orElse: () => WorkoutLevel.BEGINNER,
      ),
      imageUrl:
          json['imageUrl'] ??
          'https://placehold.co/400x300/cccccc/ffffff?text=Workout',
      isCustom: json['isCustom'] ?? false,
    );
  }
}
