import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultsPage extends StatelessWidget {
  final String title;
  final List<WorkoutModel> workouts;

  const ResultsPage({super.key, required this.title, required this.workouts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: workouts.isEmpty
          ? const Center(child: Text('No workouts found for this category'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: WorkoutCardVariant2(
                    title: workout.title,
                    duration: '${workout.duration} min',
                    level: workout.level,
                    imageUrl: workout.imageUrl,
                    onTap: () {
                      context.push('/exercise-list', extra: workout);
                    },
                  ),
                );
              },
            ),
    );
  }
}
