import 'package:ai_fitness_app/widgets/workout/workout_card.dart';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/common/flowstate_bottom_nav_bar.dart';
import '../widgets/common/section_header.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Training',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: ListView(
        children: [
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
                WorkoutCard(
                  name: 'Full Body HIIT',
                  duration: '45 minutes',
                  energyLevel: 3,
                ),
                WorkoutCard(
                  name: 'Morning Yoga Flow',
                  duration: '30 minutes',
                  energyLevel: 1,
                ),
                WorkoutCard(
                  name: 'Core Strength',
                  duration: '20 minutes',
                  energyLevel: 2,
                ),
              ],
            ),
          ),

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
                WorkoutCard(
                  name: 'Full Body HIIT',
                  duration: '45 minutes',
                  energyLevel: 3,
                ),
                WorkoutCard(
                  name: 'Morning Yoga Flow',
                  duration: '30 minutes',
                  energyLevel: 1,
                ),
                WorkoutCard(
                  name: 'Core Strength',
                  duration: '20 minutes',
                  energyLevel: 2,
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
            case 1:
              Navigator.pushNamed(context, '/profile');
              break;
            case 2:
              Navigator.pushNamed(context, '/pose');
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
