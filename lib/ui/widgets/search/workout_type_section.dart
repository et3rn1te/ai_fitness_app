import 'package:ai_fitness_app/core/models/workout_type_model.dart';
import 'package:ai_fitness_app/core/viewmodels/category_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/search/workout_type_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class WorkoutTypeSection extends StatelessWidget {
  const WorkoutTypeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Workout Type',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: StreamBuilder<List<WorkoutTypeModel>>(
            stream: viewModel.getWorkoutTypesStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final workoutTypes = snapshot.data ?? [];
              final itemsPerRow = 5;
              final rowCount = (workoutTypes.length / itemsPerRow).ceil();

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: rowCount,
                itemBuilder: (context, columnIndex) {
                  return Column(
                    children: [
                      // First Row
                      Row(
                        children: List.generate(itemsPerRow, (rowIndex) {
                          final index =
                              columnIndex * (itemsPerRow * 2) + rowIndex;
                          if (index >= workoutTypes.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: WorkoutTypeItem(
                              name: workoutTypes[index].name,
                              icon: _getWorkoutTypeIcon(
                                workoutTypes[index].name,
                              ),
                              onTap: () => _onWorkoutTypeSelected(
                                context,
                                workoutTypes[index],
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 16),
                      // Second Row
                      Row(
                        children: List.generate(itemsPerRow, (rowIndex) {
                          final index =
                              columnIndex * (itemsPerRow * 2) +
                              itemsPerRow +
                              rowIndex;
                          if (index >= workoutTypes.length) {
                            return const SizedBox.shrink();
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: WorkoutTypeItem(
                              name: workoutTypes[index].name,
                              icon: _getWorkoutTypeIcon(
                                workoutTypes[index].name,
                              ),
                              onTap: () => _onWorkoutTypeSelected(
                                context,
                                workoutTypes[index],
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  IconData _getWorkoutTypeIcon(String workoutTypeName) {
    switch (workoutTypeName.toLowerCase()) {
      case 'hiit':
        return Icons.flash_on;
      case 'warm up':
        return Icons.whatshot;
      case 'fat burn':
        return Icons.local_fire_department;
      case 'build muscle':
        return Icons.fitness_center;
      case 'stretch':
        return Icons.accessibility_new;
      case 'core':
        return Icons.center_focus_strong;
      case 'cardio':
        return Icons.directions_run;
      case 'tone up':
        return Icons.sports_gymnastics;
      case 'full body':
        return Icons.person;
      case 'recovery':
        return Icons.refresh;
      default:
        return Icons.fitness_center;
    }
  }

  void _onWorkoutTypeSelected(
    BuildContext context,
    WorkoutTypeModel workoutType,
  ) async {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);
    final workouts = await viewModel.getWorkoutsByType(workoutType.id);

    if (context.mounted) {
      context.push(
        '/results',
        extra: {'workoutTypeName': workoutType.name, 'workouts': workouts},
      );
    }
  }
}
