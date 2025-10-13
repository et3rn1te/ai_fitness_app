import 'package:ai_fitness_app/features/workouts/viewmodels/results_viewmodel.dart';
import 'package:ai_fitness_app/features/workouts/widgets/workout_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// The page is now much simpler. It only receives the title.
class ResultsPage extends StatelessWidget {
  final String title;

  const ResultsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // The Consumer widget rebuilds the UI when the ViewModel changes.
    return Consumer<ResultsViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: _buildAppBar(context, viewModel),
          body: _buildBody(context, viewModel),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ResultsViewModel viewModel,
  ) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.pop(),
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                // Display workout count from the ViewModel's state
                Text(
                  viewModel.isLoading
                      ? '...'
                      : '${viewModel.workouts.length} workouts',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, ResultsViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.errorMessage != null) {
      return Center(child: Text("Error: ${viewModel.errorMessage}"));
    }
    if (viewModel.workouts.isEmpty) {
      return _buildEmptyState();
    }

    // Build the list from the ViewModel's data
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.workouts.length,
      itemBuilder: (context, index) {
        final workout = viewModel.workouts[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: WorkoutCardVariant2(
            workout: workout,
            onTap: () {
              context.push('/workout/${workout.id}');
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    // ... This widget remains exactly the same as before.
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No workouts found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try selecting a different category',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }
}
