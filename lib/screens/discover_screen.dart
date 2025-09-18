import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/flowstate_app_bar.dart';
import '../widgets/flowstate_bottom_nav_bar.dart';
import '../widgets/workout_plan_card.dart';
import '../widgets/section_header.dart';
import '../screens/workout_screen.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlowstateAppBar(title: 'Discover'),
      body: ListView(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search workouts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant,
              ),
            ),
          ),

          // Categories Section
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SectionHeader(title: 'Categories', actionLabel: 'See All'),
          ),

          // Categories List
          SizedBox(
            height: 120,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _CategoryCard(
                  icon: Icons.fitness_center,
                  title: 'Strength',
                  color: AppTheme.primaryBlue,
                ),
                _CategoryCard(
                  icon: Icons.directions_run,
                  title: 'Cardio',
                  color: Colors.orange,
                ),
                _CategoryCard(
                  icon: Icons.self_improvement,
                  title: 'Yoga',
                  color: Colors.purple,
                ),
                _CategoryCard(
                  icon: Icons.sports_martial_arts,
                  title: 'HIIT',
                  color: Colors.red,
                ),
                _CategoryCard(
                  icon: Icons.accessibility_new,
                  title: 'Flexibility',
                  color: Colors.green,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Trending Workouts
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SectionHeader(
              title: 'Trending Workouts',
              actionLabel: 'View All',
            ),
          ),

          // Trending Workout Cards
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                WorkoutPlanCard(
                  title: 'Full Body HIIT',
                  duration: '45 minutes',
                  level: 'Advanced',
                  accentColor: Colors.red,
                  imageUrl: 'https://picsum.photos/seed/hiit/400/300',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutScreen(
                        workoutName: 'Full Body HIIT',
                        duration: '45 minutes',
                        level: 'Advanced',
                        accentColor: Colors.red,
                        imageUrl: 'https://picsum.photos/seed/hiit/400/300',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                WorkoutPlanCard(
                  title: 'Morning Yoga Flow',
                  duration: '30 minutes',
                  level: 'Beginner',
                  accentColor: Colors.purple,
                  imageUrl: 'https://picsum.photos/seed/yoga/400/300',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutScreen(
                        workoutName: 'Morning Yoga Flow',
                        duration: '30 minutes',
                        level: 'Beginner',
                        accentColor: Colors.purple,
                        imageUrl: 'https://picsum.photos/seed/yoga/400/300',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                WorkoutPlanCard(
                  title: 'Core Strength',
                  duration: '20 minutes',
                  level: 'Intermediate',
                  accentColor: AppTheme.primaryBlue,
                  imageUrl: 'https://picsum.photos/seed/core/400/300',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutScreen(
                        workoutName: 'Core Strength',
                        duration: '20 minutes',
                        level: 'Intermediate',
                        accentColor: AppTheme.primaryBlue,
                        imageUrl: 'https://picsum.photos/seed/core/400/300',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlowstateBottomNavBar(
        currentIndex: 1, // Discover tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
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

class _CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const _CategoryCard({
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Card(
        elevation: 0,
        color: color.withOpacity(0.1),
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 32),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
