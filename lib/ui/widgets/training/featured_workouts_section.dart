import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/ui/widgets/common/section_title.dart';
import 'package:ai_fitness_app/core/viewmodels/workout_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_card_1.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FeaturedWorkoutsSection extends StatelessWidget {
  const FeaturedWorkoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SectionTitle(title: 'Featured Workouts'),
        ),
        SizedBox(
          height: 200,
          child: StreamBuilder<List<WorkoutModel>>(
            stream: Provider.of<WorkoutViewModel>(
              context,
              listen: false,
            ).getFeaturedWorkoutsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final workouts = snapshot.data ?? [];

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: workouts.length,
                itemBuilder: (context, index) {
                  final workout = workouts[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: WorkoutCardVariant1(
                      title: workout.title,
                      duration: '${workout.duration} min',
                      level: workout.level,
                      backgroundImageUrl: workout.imageUrl,
                      onTap: () => _navigateToWorkoutDetails(context, workout),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _navigateToWorkoutDetails(BuildContext context, WorkoutModel workout) {
    context.push('/exercise-list', extra: workout);
  }
}
