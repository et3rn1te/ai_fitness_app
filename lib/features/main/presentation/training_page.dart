import 'package:ai_fitness_app/data/remote/workout_api_service.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_card_model.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_summary_model.dart';
import 'package:ai_fitness_app/features/main/widgets/training_banner.dart';
import 'package:ai_fitness_app/shared/widgets/workout_card_1.dart';
import 'package:ai_fitness_app/shared/widgets/workout_card_2.dart';
import 'package:ai_fitness_app/shared/widgets/custom_appbar.dart';
import 'package:ai_fitness_app/shared/widgets/custom_bottomnav.dart';
import 'package:ai_fitness_app/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final WorkoutApiService _apiService = WorkoutApiService();

  late Future<List<WorkoutCard>> _featuredWorkouts;
  late Future<List<WorkoutSummary>> _popularWorkouts;
  late Future<List<WorkoutCard>> _beginnerWorkouts;

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  void _loadWorkouts() {
    // In a real app, you'd use query params like {'category': 'featured'}
    _featuredWorkouts = _apiService.fetchWorkoutCard();
    _popularWorkouts = _apiService.fetchWorkoutSummary();
    _beginnerWorkouts = _apiService.fetchWorkoutCard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Training',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/category'),
          ),
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TrainingBanner(),

            // Featured Workouts Section (uses Card Variant 1)
            SectionTitle(title: 'Featured Workouts', onSeeAll: () {}),
            _buildHorizontalCardList(_featuredWorkouts),

            // Popular Workouts Section (uses Card Variant 2)
            const SizedBox(height: 24),
            SectionTitle(title: 'Popular Workouts', onSeeAll: () {}),
            _buildTwoRowCardList(_popularWorkouts),

            // Beginner Friendly Section (uses Card Variant 1)
            const SizedBox(height: 24),
            SectionTitle(title: 'Beginner Friendly', onSeeAll: () {}),
            _buildHorizontalCardList(_beginnerWorkouts),

            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to Home
              context.push('/home');
              break;
            case 1:
              // Already on Training
              break;
            case 2:
              // Navigate to Pose
              context.push('/pose_detection');
              break;
            case 3:
              // Navigate to Settings
              context.push('/settings');
              break;
          }
        },
      ),
    );
  }

  /// Builds a standard horizontal list view using WorkoutCardVariant1.
  Widget _buildHorizontalCardList(Future<List<WorkoutCard>> futureWorkouts) {
    return SizedBox(
      height: 200,
      child: FutureBuilder<List<WorkoutCard>>(
        future: futureWorkouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No workouts found.'));
          }

          final workouts = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutCardVariant1(
                workout: workout,
                onTap: () => context.push('/workout/${workout.id}'),
              );
            },
          );
        },
      ),
    );
  }

  /// Builds the two-row horizontal list view using WorkoutCardVariant2.
  Widget _buildTwoRowCardList(Future<List<WorkoutSummary>> futureWorkouts) {
    return SizedBox(
      height: 250, // Adjusted height for two cards + padding
      child: FutureBuilder<List<WorkoutSummary>>(
        future: futureWorkouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No popular workouts found.'));
          }

          final workouts = snapshot.data!;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: (workouts.length / 2).ceil(),
            itemBuilder: (context, columnIndex) {
              final int firstIndex = columnIndex * 2;
              final int secondIndex = firstIndex + 1;

              return SizedBox(
                width:
                    MediaQuery.of(context).size.width -
                    48, // Adjust width as needed
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Column(
                    children: [
                      WorkoutCardVariant2(
                        workout: workouts[firstIndex],
                        onTap: () =>
                            context.push('/workout/${workouts[firstIndex].id}'),
                      ),
                      const SizedBox(height: 16),
                      // Check if a workout exists for the second row
                      if (secondIndex < workouts.length)
                        WorkoutCardVariant2(
                          workout: workouts[secondIndex],
                          onTap: () => context.push(
                            '/workout/${workouts[secondIndex].id}',
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
    );
  }
}
