enum ExerciseUnit { REPS, SECONDS, UNKNOWN }

class ExerciseSummary {
  final int id;
  final String title;
  final String? animationUrl;
  final ExerciseUnit unit;
  final int? defaultValue;

  ExerciseSummary({
    required this.id,
    required this.title,
    this.animationUrl,
    required this.unit,
    this.defaultValue,
  });

  // Helper getter to create the display string (e.g., "x15" or "30s")
  String get displayValue {
    if (defaultValue == null) return '';
    if (unit == ExerciseUnit.REPS) {
      return 'x$defaultValue';
    } else if (unit == ExerciseUnit.SECONDS) {
      return '${defaultValue}s';
    }
    return defaultValue.toString();
  }

  factory ExerciseSummary.fromJson(Map<String, dynamic> json) {
    return ExerciseSummary(
      id: json['id'],
      title: json['title'],
      animationUrl: json['animationUrl'],
      unit: ExerciseUnit.values.firstWhere(
        (e) => e.name == json['unit'],
        orElse: () => ExerciseUnit.UNKNOWN,
      ),
      defaultValue: json['defaultValue'],
    );
  }
}
