import 'package:flutter/material.dart';
import '../../widgets/common/primary_action_button.dart';
import '../../widgets/workout/workout_exercise_item.dart';

class WorkoutScreen extends StatelessWidget {
  final String workoutName;
  final String duration;
  final String level;
  final Color accentColor;
  final String? imageUrl;

  const WorkoutScreen({
    super.key,
    required this.workoutName,
    required this.duration,
    required this.level,
    required this.accentColor,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              // Workout Header
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      // TODO: Implement workout editing
                    },
                    color: Colors.white,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Workout Image
                      if (imageUrl != null)
                        Image.network(imageUrl!, fit: BoxFit.cover),
                      // Gradient Overlay
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.4),
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Workout Info
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Workout Name
                      Text(
                        workoutName,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // Info Badges
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    duration.split(
                                      ' ',
                                    )[0], // Extract the number
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: accentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Duration',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: accentColor.withOpacity(0.8),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: accentColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '${_exercises.length}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: accentColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Exercises',
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(
                                          color: accentColor.withOpacity(0.8),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Exercises Section Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Exercises',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // TODO: Implement exercise list editing
                            },
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Edit'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Exercises List
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final exercise = _exercises[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: WorkoutExerciseItem(
                      name: exercise.name,
                      duration: '${(index + 1) * 45} seconds',
                      animationUrl: '', // TODO: Add exercise animations
                      order: index,
                      onTap: () {
                        // TODO: Show exercise details
                      },
                    ),
                  );
                }, childCount: _exercises.length),
              ),

              // Bottom Padding for Start Button
              const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
            ],
          ),

          // Sticky Start Button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: PrimaryActionButton(
                text: 'Start Workout',
                onPressed: () {
                  Navigator.pushNamed(context, '/workout-player');
                },
                icon: Icons.play_circle_outline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Example exercises - this would typically come from the workout plan's data
  static final List<_Exercise> _exercises = [
    const _Exercise(
      name: 'Warm-up Stretches',
      category: 'Warm-up',
      icon: Icons.accessibility_new,
    ),
    const _Exercise(
      name: 'Jumping Jacks',
      category: 'Cardio',
      icon: Icons.accessibility,
    ),
    const _Exercise(
      name: 'Push-ups',
      category: 'Upper Body',
      icon: Icons.fitness_center,
    ),
    const _Exercise(
      name: 'Squats',
      category: 'Lower Body',
      icon: Icons.accessibility_new,
    ),
    const _Exercise(
      name: 'Mountain Climbers',
      category: 'Core',
      icon: Icons.accessibility,
    ),
    const _Exercise(
      name: 'Plank Hold',
      category: 'Core',
      icon: Icons.horizontal_rule,
    ),
    const _Exercise(
      name: 'Burpees',
      category: 'Full Body',
      icon: Icons.accessibility_new,
    ),
    const _Exercise(
      name: 'Cool-down Stretches',
      category: 'Cool-down',
      icon: Icons.accessibility,
    ),
  ];
}

class _Exercise {
  final String name;
  final String category;
  final IconData icon;

  const _Exercise({
    required this.name,
    required this.category,
    required this.icon,
  });
}
