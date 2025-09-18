import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/flowstate_app_bar.dart';
import '../widgets/primary_action_button.dart';
import '../widgets/section_header.dart';
import '../widgets/workout_plan_card.dart';
import '../widgets/flowstate_bottom_nav_bar.dart';
import '../screens/workout_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

          // Quick start button
          PrimaryActionButton(
            text: 'Start New Workout',
            onPressed: () {
              Navigator.pushNamed(context, '/workout-player');
            },
            icon: Icons.play_circle_outline,
          ),
          const SizedBox(height: 32),

          // Workout Plans Section
          const SectionHeader(
            title: 'Your Workout Plans',
            actionLabel: 'View All',
            onActionPressed: null, // TODO: Implement view all functionality
          ),

          // Workout Plan Carousel
          SizedBox(
            height: 200, // Fixed height for the carousel
            child: PageView(
              controller: PageController(viewportFraction: 0.9),
              padEnds: false,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: WorkoutPlanCard(
                    title: 'Full Body Strength',
                    duration: '45 minutes',
                    level: 'Intermediate',
                    accentColor: AppTheme.primaryBlue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutScreen(
                          workoutName: 'Full Body Strength',
                          duration: '45 minutes',
                          level: 'Intermediate',
                          accentColor: AppTheme.primaryBlue,
                          imageUrl:
                              'https://picsum.photos/seed/strength/400/300',
                        ),
                      ),
                    ),
                    imageUrl: 'https://picsum.photos/seed/strength/400/300',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: WorkoutPlanCard(
                    title: 'HIIT Cardio',
                    duration: '30 minutes',
                    level: 'Advanced',
                    accentColor: AppTheme.primaryBlue,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutScreen(
                          workoutName: 'HIIT Cardio',
                          duration: '30 minutes',
                          level: 'Advanced',
                          accentColor: AppTheme.primaryBlue,
                          imageUrl: 'https://picsum.photos/seed/cardio/400/300',
                        ),
                      ),
                    ),
                    imageUrl: 'https://picsum.photos/seed/cardio/400/300',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: WorkoutPlanCard(
                    title: 'Mobility Flow',
                    duration: '20 minutes',
                    level: 'Beginner',
                    accentColor: Colors.orange,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutScreen(
                          workoutName: 'Mobility Flow',
                          duration: '20 minutes',
                          level: 'Beginner',
                          accentColor: Colors.orange,
                          imageUrl:
                              'https://picsum.photos/seed/mobility/400/300',
                        ),
                      ),
                    ),
                    imageUrl: 'https://picsum.photos/seed/mobility/400/300',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlowstateBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.pushNamed(context, '/discover');
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
