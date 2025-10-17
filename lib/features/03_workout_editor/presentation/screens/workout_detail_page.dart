import 'package:ai_fitness_app/data/services/workout_api_service.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_detail_model.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/exercise_list.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/image_header.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/widgets/detail/info_section.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutDetailPage extends StatefulWidget {
  final int workoutId;
  const WorkoutDetailPage({Key? key, required this.workoutId})
    : super(key: key);

  @override
  State<WorkoutDetailPage> createState() => _WorkoutDetailPageState();
}

class _WorkoutDetailPageState extends State<WorkoutDetailPage> {
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
          return WorkoutDetailContent(
            workout: snapshot.data!,
          ); // Đổi tên _WorkoutDetailContent thành public
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
      body: CustomScrollView(
        slivers: [
          ImageHeader(
            imageUrl: workout.imageUrl,
            onBackPressed: () => context.pop(),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoSection(
                    title: workout.title,
                    duration: workout.duration,
                    totalExercises: workout.totalExercises,
                  ),
                  ExerciseList(exercises: workout.exercises),
                  // Để khoảng trống cho nút bấm
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              print('Button Pressed! Starting workout: ${workout.title}');
              context.pushNamed('workout-player', extra: workout);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'Start Workout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
