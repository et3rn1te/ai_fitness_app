import 'package:ai_fitness_app/features/workouts/widgets/custom_workout_banner.dart';
import 'package:ai_fitness_app/features/workouts/widgets/daily_challenge.dart';
import 'package:ai_fitness_app/features/workouts/widgets/workout_streak.dart';
import 'package:ai_fitness_app/shared/widgets/custom_appbar.dart';
import 'package:ai_fitness_app/shared/widgets/custom_bottomnav.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Flowstate'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WorkoutStreak(
              streakDays: 5,
              weeklyProgress: [true, true, true, true, true, false, false],
            ),
            const DailyChallenge(),
            CustomWorkoutBanner(
              onTap: () {
                context.push('/custom_workout');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              // Already on Home
              break;
            case 1:
              // Navigate to Training
              context.push('/training');
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
}
