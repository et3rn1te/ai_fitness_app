enum WorkoutLevel { BEGINNER, INTERMEDIATE, ADVANCED }

class WorkoutCard {
  final int id;
  final String title;
  final String imageUrl;

  WorkoutCard({required this.id, required this.title, required this.imageUrl});

  factory WorkoutCard.fromJson(Map<String, dynamic> json) {
    return WorkoutCard(
      id: json['id'],
      title: json['title'],
      imageUrl:
          json['imageUrl'] ??
          'https://placehold.co/400x300/cccccc/ffffff?text=Workout',
    );
  }
}
