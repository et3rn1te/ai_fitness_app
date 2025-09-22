import 'package:ai_fitness_app/ui/widgets/common/custom_appbar.dart';
import 'package:ai_fitness_app/ui/widgets/common/custom_bottomnav.dart';
import 'package:ai_fitness_app/ui/widgets/common/section_title.dart';
import 'package:ai_fitness_app/ui/widgets/training/training_banner.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_card_1.dart';
import 'package:ai_fitness_app/ui/widgets/workout/workout_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Training',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              context.push('/category');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Handle settings
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TrainingBanner(),

            // Featured Workouts Section
            SectionTitle(
              title: 'Featured Workouts',
              onSeeAll: () {
                // Handle see all
              },
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  WorkoutCardVariant1(
                    title: 'Full Body HIIT',
                    duration: '45 min',
                    level: 'Intermediate',
                    backgroundImageUrl: 'https://picsum.photos/id/237/200/300',
                    onTap: () {},
                  ),
                  WorkoutCardVariant1(
                    title: 'Core Strength',
                    duration: '30 min',
                    level: 'Advanced',
                    backgroundImageUrl: 'https://picsum.photos/id/237/200/300',
                    onTap: () {},
                  ),
                ],
              ),
            ),

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
                            imageUrl: 'https://picsum.photos/id/237/200/300',
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
                              imageUrl: 'https://picsum.photos/id/237/200/300',
                              onTap: () {},
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Beginner Friendly Section
            SectionTitle(
              title: 'Beginner Friendly',
              onSeeAll: () {
                // Handle see all
              },
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                children: [
                  WorkoutCardVariant1(
                    title: 'Full Body HIIT',
                    duration: '45 min',
                    level: 'Intermediate',
                    backgroundImageUrl: 'https://picsum.photos/id/237/200/300',
                    onTap: () {},
                  ),
                  WorkoutCardVariant1(
                    title: 'Core Strength',
                    duration: '30 min',
                    level: 'Advanced',
                    backgroundImageUrl: 'https://picsum.photos/id/237/200/300',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Add some bottom padding
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
              // Navigate to Pose Detection
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
