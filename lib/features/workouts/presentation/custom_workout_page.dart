import 'package:ai_fitness_app/data/remote/workout_api_service.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_summary_model.dart';
import 'package:ai_fitness_app/features/search/presentation/add_exercises_dialog.dart';
import 'package:ai_fitness_app/shared/widgets/workout_card_3.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomWorkoutPage extends StatefulWidget {
  const CustomWorkoutPage({super.key});

  @override
  State<CustomWorkoutPage> createState() => _CustomWorkoutPageState();
}

class _CustomWorkoutPageState extends State<CustomWorkoutPage> {
  late Future<List<WorkoutSummary>> _futureCustomWorkouts;
  final WorkoutApiService _apiService = WorkoutApiService();

  @override
  void initState() {
    super.initState();
    // Fetch workouts specifically marked as 'custom'
    _futureCustomWorkouts = _apiService.fetchWorkoutSummary(
      queryParams: {'isCustom': 'true'},
    );
  }

  // In your CustomWorkoutPage...
  void _showCreateWorkoutPopup() async {
    final List<int>? selectedIds = await showModalBottomSheet<List<int>>(
      context: context,
      isScrollControlled: true, // Important for the DraggableScrollableSheet
      backgroundColor: Colors.transparent,
      builder: (context) => const AddExercisesDialog(),
    );

    if (selectedIds != null && selectedIds.isNotEmpty) {
      // Here you would handle the logic to create a new custom workout
      // using the selected exercise IDs. For example, navigate to a
      // new page or call another API endpoint.
      print('Selected exercise IDs: $selectedIds');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CUSTOM WORKOUT'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: FutureBuilder<List<WorkoutSummary>>(
        future: _futureCustomWorkouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final workouts = snapshot.data ?? [];

          if (workouts.isEmpty) {
            return _buildEmptyState();
          } else {
            return _buildWorkoutList(workouts);
          }
        },
      ),
    );
  }

  // Widget for the empty state
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
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Widget for displaying the list of workouts
  Widget _buildWorkoutList(List<WorkoutSummary> workouts) {
    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.all(
            16,
          ).copyWith(bottom: 80), // Padding to avoid overlap with button
          itemCount: workouts.length,
          itemBuilder: (context, index) {
            final workout = workouts[index];
            return WorkoutCardVariant3(
              workout: workout,
              onTap: () {
                // Navigate to the workout detail page
                context.push('/workout/${workout.id}');
              },
            );
          },
        ),
        // Positioned Create button at the bottom
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
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
