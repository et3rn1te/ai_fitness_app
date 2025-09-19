import 'package:flutter/material.dart';
import '../widgets/common/flowstate_app_bar.dart';
import '../widgets/common/section_header.dart';
import '../widgets/workout/workout_streak_calendar.dart';
import '../widgets/common/flowstate_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Example workout days for the calendar
    final workoutDays = [
      DateTime.now().subtract(const Duration(days: 1)),
      DateTime.now().subtract(const Duration(days: 2)),
      DateTime.now().subtract(const Duration(days: 3)),
      DateTime.now().subtract(const Duration(days: 5)),
      DateTime.now().subtract(const Duration(days: 6)),
    ];

    return Scaffold(
      appBar: const FlowstateAppBar(title: 'Flowstate'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Welcome message
          Text(
            'Welcome back, User!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Section 1: Workout Streak Calendar
          const SectionHeader(
            title: 'Your Progress',
            actionLabel: 'View Stats',
            onActionPressed: null,
          ),
          const SizedBox(height: 16),
          WorkoutStreakCalendar(workoutDays: workoutDays, currentStreak: 3),
          const SizedBox(height: 32),

          // Section 2: Pose Detection Feature
          const SectionHeader(
            title: 'Pose Detection',
            actionLabel: 'See All',
            onActionPressed: null,
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(padding: const EdgeInsets.only(right: 8)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Section 3: Custom Workout Banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Your Own Workout',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Design a custom workout plan that fits your goals and schedule',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Navigate to custom workout creation
                    Navigator.pushNamed(context, '/create-workout');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      bottomNavigationBar: FlowstateBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/training');
              break;
            case 1:
              Navigator.pushNamed(context, '/pose');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
