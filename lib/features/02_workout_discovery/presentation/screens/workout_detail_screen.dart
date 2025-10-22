import 'package:ai_fitness_app/data/services/workout_api_service.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_detail_model.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/exercise_list.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/image_header.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/info_section.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/start_workout_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutDetailScreen extends StatefulWidget {
  final int workoutId;
  const WorkoutDetailScreen({Key? key, required this.workoutId})
    : super(key: key);

  @override
  State<WorkoutDetailScreen> createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  late Future<WorkoutDetail> futureWorkoutDetail;
  final WorkoutApiService apiService = WorkoutApiService();

  @override
  void initState() {
    super.initState();
    futureWorkoutDetail = apiService.fetchWorkoutDetail(widget.workoutId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WorkoutDetail>(
      future: futureWorkoutDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: Center(child: Text("Error fetching data: ${snapshot.error}")),
          );
        }
        if (snapshot.hasData) {
          return WorkoutDetailContent(workout: snapshot.data!);
        }
        return const Scaffold(
          body: Center(child: Text("No workout data found.")),
        );
      },
    );
  }
}

class WorkoutDetailContent extends StatelessWidget {
  final WorkoutDetail workout;

  const WorkoutDetailContent({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ImageHeader(
                imageUrl: workout.imageUrl,
                onBackPressed: () => context.pop(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InfoSection(
                        title: workout.title,
                        duration: workout.duration,
                        totalExercises: workout.totalExercises,
                      ),
                      ExerciseList(exercises: workout.exercises),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ],
          ),
          StartWorkoutButton(
            onPressed: () {
              print('Button Pressed! Starting workout: ${workout.title}');
              context.push('/workout-player', extra: workout);
            },
          ),
        ],
      ),
    );
  }
}
