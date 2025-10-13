import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:ai_fitness_app/features/workouts/viewmodels/training_viewmodel.dart';
import 'package:ai_fitness_app/features/workouts/widgets/training_banner.dart';
import 'package:ai_fitness_app/features/workouts/widgets/workout_card_1.dart';
import 'package:ai_fitness_app/features/workouts/widgets/workout_card_2.dart';
import 'package:ai_fitness_app/shared/widgets/custom_appbar.dart';
import 'package:ai_fitness_app/shared/widgets/custom_bottomnav.dart';
import 'package:ai_fitness_app/shared/widgets/section_title.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({super.key});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  // This is the only logic left in the StatefulWidget:
  // We tell the ViewModel to start loading data when the page is first built.
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure the context is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // We access the ViewModel via Provider and tell it to load its data.
      // `listen: false` is important because we only want to call this once.
      Provider.of<TrainingViewModel>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // We use a Consumer widget to listen for changes in the TrainingViewModel.
    // Whenever the ViewModel calls `notifyListeners()`, this part of the UI rebuilds.
    return Consumer<TrainingViewModel>(
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
          body: _buildBody(context, viewModel),
          bottomNavigationBar: CustomBottomNav(
            currentIndex: 1,
            onTap: (index) {},
          ),
        );
      },
    );
  }

  // The main body is now a simple helper function.
  Widget _buildBody(BuildContext context, TrainingViewModel viewModel) {
    // Handle the loading state
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    // Handle the error state
    if (viewModel.errorMessage != null) {
      return Center(child: Text(viewModel.errorMessage!));
    }
    // Display the data when it's ready
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TrainingBanner(),
          SectionTitle(title: 'Featured Workouts', onSeeAll: () {}),
          _buildHorizontalCardList(
            viewModel.featuredWorkouts,
          ), // Pass data from ViewModel
          const SizedBox(height: 24),
          SectionTitle(title: 'Popular Workouts', onSeeAll: () {}),
          _buildTwoRowCardList(
            viewModel.popularWorkouts,
          ), // Pass data from ViewModel
          const SizedBox(height: 24),
          SectionTitle(title: 'Beginner Friendly', onSeeAll: () {}),
          _buildHorizontalCardList(
            viewModel.beginnerWorkouts,
          ), // Pass data from ViewModel
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // These helper methods are now "dumb". They just receive data and build widgets.
  // They have no knowledge of Futures or API calls.
  Widget _buildHorizontalCardList(List<WorkoutSummary> workouts) {
    if (workouts.isEmpty)
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No workouts found.')),
      );
    return SizedBox(
      height: 200,
      child: ListView.builder(
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
    );
  }

  Widget _buildTwoRowCardList(List<WorkoutSummary> workouts) {
    if (workouts.isEmpty)
      return const SizedBox(
        height: 240,
        child: Center(child: Text('No workouts found.')),
      );
    return SizedBox(
      height: 240,
      child: ListView.builder(
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
                  WorkoutCardVariant2(
                    workout: workouts[firstIndex],
                    onTap: () =>
                        context.push('/workout/${workouts[firstIndex].id}'),
                  ),
                  const SizedBox(height: 16),
                  if (secondIndex < workouts.length)
                    WorkoutCardVariant2(
                      workout: workouts[secondIndex],
                      onTap: () =>
                          context.push('/workout/${workouts[secondIndex].id}'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
