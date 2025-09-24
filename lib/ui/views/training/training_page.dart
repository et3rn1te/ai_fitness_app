import 'package:ai_fitness_app/core/repositories/workout_repository.dart';
import 'package:ai_fitness_app/core/viewmodels/workout_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/common/custom_appbar.dart';
import 'package:ai_fitness_app/ui/widgets/common/custom_bottomnav.dart';
import 'package:ai_fitness_app/ui/widgets/training/featured_workouts_section.dart';
import 'package:ai_fitness_app/ui/widgets/training/popular_workouts_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// screens/training_page.dart
class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Use MultiProvider if you have multiple providers
      providers: [
        ChangeNotifierProvider(
          create: (_) => WorkoutViewModel(WorkoutRepository()),
        ),
      ],
      child: const TrainingPageContent(),
    );
  }
}

// Create a separate content widget
class TrainingPageContent extends StatelessWidget {
  const TrainingPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Training',
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeaturedWorkoutsSection(),
            SizedBox(height: 24),
            PopularWorkoutsSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              // Already on Training page
              break;
            case 2:
              context.go('/pose');
              break;
            case 3:
              context.go('/settings');
              break;
          }
        },
      ),
    );
  }
}
