import 'package:flutter/material.dart';
import '../widgets/flowstate_app_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/flowstate_bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  final Function(ThemeMode) onThemeChanged;
  final ThemeMode currentTheme;

  const ProfileScreen({
    super.key,
    required this.onThemeChanged,
    required this.currentTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlowstateAppBar(title: 'My Profile'),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User info section
          Row(
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 16),
              // User details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Intermediate Level',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Theme toggle section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Appearance'),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      currentTheme == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      currentTheme == ThemeMode.dark
                          ? 'Dark Mode'
                          : 'Light Mode',
                    ),
                    trailing: Switch(
                      value: currentTheme == ThemeMode.dark,
                      onChanged: (bool value) {
                        onThemeChanged(
                          value ? ThemeMode.dark : ThemeMode.light,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Workout history section
          const SectionHeader(
            title: 'Workout History',
            actionLabel: 'See All',
            onActionPressed: null, // TODO: Implement see all functionality
          ),

          // Workout history cards
          _WorkoutHistoryCard(
            workout: 'Full Body Strength',
            date: 'Today',
            stats: '45 minutes • 300 calories',
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 12),
          _WorkoutHistoryCard(
            workout: 'HIIT Cardio',
            date: 'Yesterday',
            stats: '30 minutes • 250 calories',
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _WorkoutHistoryCard(
            workout: 'Mobility Flow',
            date: '2 days ago',
            stats: '20 minutes • 150 calories',
            color: Colors.purple,
          ),
          const SizedBox(height: 12),
          _WorkoutHistoryCard(
            workout: 'Full Body Strength',
            date: '3 days ago',
            stats: '45 minutes • 320 calories',
            color: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
      bottomNavigationBar: FlowstateBottomNavBar(
        currentIndex: 2, // Profile tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/discover');
              break;
          }
        },
      ),
    );
  }
}

class _WorkoutHistoryCard extends StatelessWidget {
  final String workout;
  final String date;
  final String stats;
  final Color color;

  const _WorkoutHistoryCard({
    required this.workout,
    required this.date,
    required this.stats,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        workout,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(date, style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stats,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
