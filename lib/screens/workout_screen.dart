import 'package:flutter/material.dart';
import '../widgets/exercise_card.dart';
import '../widgets/primary_action_button.dart';

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
      body: CustomScrollView(
        slivers: [
          // Workout Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(workoutName),
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
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
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
                  // Workout Stats
                  Row(
                    children: [
                      Icon(Icons.timer, color: accentColor),
                      const SizedBox(width: 8),
                      Text(duration),
                      const SizedBox(width: 24),
                      Icon(Icons.fitness_center, color: accentColor),
                      const SizedBox(width: 8),
                      Text(level),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Start Workout Button
                  PrimaryActionButton(
                    text: 'Start Workout',
                    onPressed: () {
                      Navigator.pushNamed(context, '/workout-player');
                    },
                    icon: Icons.play_circle_outline,
                  ),
                  const SizedBox(height: 24),

                  // Exercises Section Header
                  Text(
                    'Exercises',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
                child: ExerciseCard(
                  name: exercise.name,
                  duration: '${(index + 1) * 45} seconds',
                  energyLevel: (index % 3 + 1),
                  imageUrl:
                      'https://picsum.photos/seed/${exercise.name.toLowerCase().replaceAll(' ', '')}/200/200',
                  onTap: () {
                    // TODO: Show exercise details
                  },
                ),
              );
            }, childCount: _exercises.length),
          ),

          // Bottom Padding
          const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
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
