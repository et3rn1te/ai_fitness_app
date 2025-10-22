import 'package:ai_fitness_app/features/02_workout_discovery/presentation/viewmodel/workout_discovery_viewmodel.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/widgets/training_banner.dart';
import 'package:ai_fitness_app/presentation/widgets/custom_appbar.dart';
import 'package:ai_fitness_app/presentation/widgets/custom_bottomnav.dart';
import 'package:ai_fitness_app/presentation/widgets/section_title.dart';
import 'package:ai_fitness_app/presentation/widgets/workout_card_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_card_model.dart';

class WorkoutDiscoveryScreen extends StatelessWidget {
  const WorkoutDiscoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The Consumer widget listens to the ViewModel and rebuilds the UI on changes.
    return Consumer<WorkoutDiscoveryViewModel>(
      builder: (context, viewModel, child) {
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

                // Featured Workouts Section
                SectionTitle(title: 'Featured Workouts', onSeeAll: () {}),
                _buildHorizontalCardList(
                  context,
                  viewModel.featuredState,
                  viewModel.featuredWorkouts,
                  viewModel.errorMessage,
                ),

                // Popular Workouts Section
                const SizedBox(height: 24),
                SectionTitle(title: 'Popular Workouts', onSeeAll: () {}),
                _buildTwoRowCardList(
                  context,
                  viewModel.popularState,
                  viewModel.popularWorkouts,
                  viewModel.errorMessage,
                ),

                // Beginner Friendly Section
                const SizedBox(height: 24),
                SectionTitle(title: 'Beginner Friendly', onSeeAll: () {}),
                _buildHorizontalCardList(
                  context,
                  viewModel.beginnerState,
                  viewModel.beginnerWorkouts,
                  viewModel.errorMessage,
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNav(
            currentIndex: 1,
            onTap: (index) {
              switch (index) {
                case 0:
                  context.push('/home');
                  break;
                case 1:
                  break;
                case 2:
                  context.push('/pose-detection');
                  break;
                case 3:
                  context.push('/settings');
                  break;
              }
            },
          ),
        );
      },
    );
  }

  /// Builds a standard horizontal list view for WorkoutCard.
  Widget _buildHorizontalCardList(
    BuildContext context,
    ViewState state,
    List<WorkoutCard> workouts,
    String? errorMessage,
  ) {
    return SizedBox(
      height: 200,
      child: _buildStateContent(
        state,
        errorMessage,
        ListView.builder(
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
        ),
      ),
    );
  }

  /// Builds the two-row horizontal list view for WorkoutSummary.
  Widget _buildTwoRowCardList(
    BuildContext context,
    ViewState state,
    List<WorkoutCard> workouts,
    String? errorMessage,
  ) {
    return SizedBox(
      height: 250, // Adjusted height for two cards + padding
      child: _buildStateContent(
        state,
        errorMessage,
        ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: (workouts.length / 2).ceil(),
          itemBuilder: (context, columnIndex) {
            final int firstIndex = columnIndex * 2;
            final int secondIndex = firstIndex + 1;

            return SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    WorkoutCardVariant1(
                      workout: workouts[firstIndex],
                      onTap: () =>
                          context.push('/workout/${workouts[firstIndex].id}'),
                    ),
                    const SizedBox(height: 16),
                    if (secondIndex < workouts.length)
                      WorkoutCardVariant1(
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
        ),
      ),
    );
  }

  /// A helper to handle showing loading, error, or success content.
  Widget _buildStateContent(ViewState state, String? error, Widget content) {
    switch (state) {
      case ViewState.loading:
      case ViewState.idle:
        return const Center(child: CircularProgressIndicator());
      case ViewState.error:
        return Center(child: Text('Error: $error'));
      case ViewState.success:
        return content;
    }
  }
}
