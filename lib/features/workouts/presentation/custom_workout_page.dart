import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:ai_fitness_app/features/workouts/viewmodels/custom_workout_viewmodel.dart';
import 'package:ai_fitness_app/features/workouts/widgets/exercises/add_exercises_dialog.dart';
import 'package:ai_fitness_app/features/workouts/widgets/workout_card_3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomWorkoutPage extends StatefulWidget {
  const CustomWorkoutPage({super.key});

  @override
  State<CustomWorkoutPage> createState() => _CustomWorkoutPageState();
}

class _CustomWorkoutPageState extends State<CustomWorkoutPage> {
  @override
  void initState() {
    super.initState();
    // Tell the ViewModel to load its data when the page is first built.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CustomWorkoutViewModel>(
        context,
        listen: false,
      ).loadCustomWorkouts();
    });
  }

  void _showCreateWorkoutPopup() async {
    // Show the dialog and wait for it to return the list of selected exercise IDs.
    final List<int>? selectedIds = await showModalBottomSheet<List<int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExercisesDialog(),
    );

    if (selectedIds != null && selectedIds.isNotEmpty && mounted) {
      // In a real app, you'd prompt the user for a workout name.
      const workoutName = "My New Custom Workout";
      // Tell the ViewModel to create the new workout.
      await Provider.of<CustomWorkoutViewModel>(
        context,
        listen: false,
      ).createWorkout(workoutName, selectedIds);
    }
  }

  @override
  Widget build(BuildContext context) {
    // The Consumer widget rebuilds the UI whenever the ViewModel calls notifyListeners().
    return Consumer<CustomWorkoutViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('CUSTOM WORKOUT'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => context.pop(),
            ),
          ),
          body: _buildBody(context, viewModel),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, CustomWorkoutViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.errorMessage != null) {
      return Center(child: Text(viewModel.errorMessage!));
    }
    if (viewModel.customWorkouts.isEmpty) {
      return _buildEmptyState();
    }
    return _buildWorkoutList(viewModel.customWorkouts);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.note_add_outlined, size: 80, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            'No Custom Workouts',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first personalized workout.',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showCreateWorkoutPopup,
            icon: const Icon(Icons.add),
            label: const Text('Create Workout'),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutList(List<WorkoutSummary> workouts) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(16).copyWith(bottom: 80),
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return WorkoutCardVariant3(
              workout: workout,
              onTap: () {
                // In the future, this will navigate to a local workout detail page.
                // context.push('/custom-workout/${workout.id}');
              },
            );
          },
        ),
        Positioned(
          bottom: 20,
          left: 20,
          right: 20,
          child: ElevatedButton.icon(
            onPressed: _showCreateWorkoutPopup,
            icon: const Icon(Icons.add),
            label: const Text('Create New Workout'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
      ],
    );
  }
}
