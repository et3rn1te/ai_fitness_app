import 'package:ai_fitness_app/data/models/workouts/workout_exercise_model.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/widgets/exercise_item.dart';
import 'package:flutter/material.dart';

class ExerciseList extends StatelessWidget {
  // Giả sử bạn có model Exercise từ file workout_detail_model.dart
  final List<WorkoutExercise> exercises;

  const ExerciseList({super.key, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Exercises',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  /* Xử lý sự kiện nhấn Edit */
                },
                child: const Row(
                  children: [Text('Edit'), Icon(Icons.chevron_right)],
                ),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: exercises.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            // ExerciseItem là widget bạn đã có sẵn
            return ExerciseItem(
              name: exercise.exerciseTitle,
              count: exercise.displayCount,
              animationUrl: exercise.exerciseAnimationUrl,
              onReplace: () {
                /* Xử lý sự kiện nhấn Replace */
              },
            );
          },
        ),
      ],
    );
  }
}
