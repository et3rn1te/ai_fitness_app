import 'package:ai_fitness_app/core/api/workout_api_service.dart';
import 'package:ai_fitness_app/core/workouts/workout_summary_model.dart';
import 'package:ai_fitness_app/shared/widgets/workout_card_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutResultsPage extends StatefulWidget {
  final String title;
  final Map<String, String> queryParams;

  const WorkoutResultsPage({
    super.key,
    required this.title,
    required this.queryParams,
  });

  @override
  State<WorkoutResultsPage> createState() => _WorkoutResultsPageState();
}

class _WorkoutResultsPageState extends State<WorkoutResultsPage> {
  late Future<List<WorkoutSummary>> _futureWorkouts;
  final WorkoutApiService _apiService = WorkoutApiService();

  @override
  void initState() {
    super.initState();
    // Fetch the workouts using the query parameters passed from the CategoryPage
    _futureWorkouts = _apiService.fetchWorkoutSummary(
      queryParams: widget.queryParams,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: FutureBuilder<List<WorkoutSummary>>(
              future: _futureWorkouts,
              builder: (context, snapshot) {
                // Determine the workout count, show '...' while loading
                String workoutCountText = '...';
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  workoutCountText = '${snapshot.data!.length} workouts';
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => context.pop(),
                      ),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        workoutCountText,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<WorkoutSummary>>(
        future: _futureWorkouts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error fetching workouts: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyState();
          }

          final workouts = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: WorkoutCardVariant2(
                  workout: workout, // Pass the full object
                  onTap: () {
                    // Navigate to workout details page using its ID
                    context.push('/workout/${workout.id}');
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
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
