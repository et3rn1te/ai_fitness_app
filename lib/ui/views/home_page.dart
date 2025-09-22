import 'package:ai_fitness_app/ui/widgets/common/custom_appbar.dart';
import 'package:ai_fitness_app/ui/widgets/common/custom_bottomnav.dart';
import 'package:ai_fitness_app/ui/widgets/workout/custom_workout_banner.dart';
import 'package:ai_fitness_app/ui/widgets/workout/daily_challenge.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_card_2.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_streak.dart';
import 'package:ai_fitness_app/ui/widgets/common/section_title.dart';
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
                // Navigate to custom workout creation
              },
            ),

            // Popular Workouts Section
            // Popular Workouts Section
            const SizedBox(height: 24),
            SectionTitle(
              title: 'Popular Workouts',
              onSeeAll: () {
                // Handle see all
              },
            ),
            SizedBox(
              height:
                  250, // Adjusted height for 2 rows (110 * 2 + some spacing)
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: (4 / 2)
                    .ceil(), // Number of columns (each column has 2 cards)
                itemBuilder: (context, columnIndex) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width - 32,
                    child: Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          // First row
                          WorkoutCardVariant2(
                            title: 'Workout ${columnIndex * 2 + 1}',
                            duration: '${30 + columnIndex * 5} min',
                            energyLevel: (columnIndex % 3) + 1,
                            imageUrl:
                                'https://example.com/workout${columnIndex * 2}.jpg',
                            onTap: () {},
                          ),
                          const SizedBox(height: 16), // Spacing between rows
                          // Second row
                          if (columnIndex * 2 + 2 <=
                              4) // Check if there's a workout for the second row
                            WorkoutCardVariant2(
                              title: 'Workout ${columnIndex * 2 + 2}',
                              duration: '${35 + columnIndex * 5} min',
                              energyLevel: ((columnIndex + 1) % 3) + 1,
                              imageUrl:
                                  'https://example.com/workout${columnIndex * 2 + 1}.jpg',
                              onTap: () {},
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
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
              context.push('/pose');
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
