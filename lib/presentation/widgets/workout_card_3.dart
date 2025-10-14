import 'package:ai_fitness_app/data/models/workouts/workout_summary_model.dart';
import 'package:flutter/material.dart';

class WorkoutCardVariant3 extends StatelessWidget {
  final WorkoutSummary workout;
  final VoidCallback? onTap;

  const WorkoutCardVariant3({super.key, required this.workout, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Determine the subtitle based on whether the workout is custom
    final String subtitle;
    if (workout.isCustom) {
      final duration = workout.duration ?? 0;
      final exerciseCount = workout.totalExercises ?? 0;
      subtitle = '$duration min • $exerciseCount exercises';
    } else {
      // Capitalize the first letter of the level
      subtitle =
          workout.level.name[0].toUpperCase() +
          workout.level.name.substring(1).toLowerCase();
    }

    // Use a default image for custom workouts
    final imageUrl = workout.isCustom
        ? 'https://images.unsplash.com/photo-1581009137042-c552e485697a?q=80&w=2070&auto=format&fit=crop' // A generic fitness image
        : workout.imageUrl;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip
          .antiAlias, // Ensures the InkWell ripple stays within the rounded corners
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            SizedBox(
              height: 150,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.fitness_center),
                ),
              ),
            ),
            // Text Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    workout.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
