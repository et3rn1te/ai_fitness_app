// widgets/training/popular_workouts_section.dart
import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/ui/widgets/common/section_title.dart';
import 'package:ai_fitness_app/core/viewmodels/workout_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PopularWorkoutsSection extends StatelessWidget {
  const PopularWorkoutsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SectionTitle(title: 'Popular Workouts'),
        ),
        SizedBox(
          height: 250, // Adjusted for 2 rows
          child: StreamBuilder<List<WorkoutModel>>(
            stream: Provider.of<WorkoutViewModel>(
              context,
              listen: false,
            ).getPopularWorkoutsStream(),
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
                itemCount: (workouts.length / 2).ceil(),
                itemBuilder: (context, columnIndex) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          // First row
                          WorkoutCardVariant2(
                            title: workouts[columnIndex * 2].title,
                            duration:
                                '${workouts[columnIndex * 2].duration} min',
                            level: workouts[columnIndex * 2].level,
                            imageUrl: workouts[columnIndex * 2].imageUrl,
                            onTap: () => _navigateToWorkoutDetails(
                              context,
                              workouts[columnIndex * 2],
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Second row (if exists)
                          if (columnIndex * 2 + 1 < workouts.length)
                            WorkoutCardVariant2(
                              title: workouts[columnIndex * 2 + 1].title,
                              duration:
                                  '${workouts[columnIndex * 2 + 1].duration} min',
                              level: workouts[columnIndex * 2 + 1].level,
                              imageUrl: workouts[columnIndex * 2 + 1].imageUrl,
                              onTap: () => _navigateToWorkoutDetails(
                                context,
                                workouts[columnIndex * 2 + 1],
                              ),
                            ),
                        ],
                      ),
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
