import 'package:ai_fitness_app/features/04_workout_player/presentation/viewmodel/workout_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ai_fitness_app/data/models/workouts/workout_detail_model.dart';

class WorkoutPlayerScreen extends StatelessWidget {
  final WorkoutDetail workout;

  const WorkoutPlayerScreen({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkoutPlayerViewModel(workout: workout)..startWorkout(),
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Consumer<WorkoutPlayerViewModel>(
          builder: (context, viewModel, child) {
            switch (viewModel.status) {
              case WorkoutStatus.ready:
                return _ReadyScreen(countdown: viewModel.countdown);
              case WorkoutStatus.playing:
                return _ExerciseScreen(viewModel: viewModel);
              case WorkoutStatus.resting:
                return _RestScreen(viewModel: viewModel);
              case WorkoutStatus.paused:
                return _PauseScreen(viewModel: viewModel);
              case WorkoutStatus.finished:
                return _FinishedScreen();
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

// --- Các Widget con cho từng trạng thái ---

class _ReadyScreen extends StatelessWidget {
  final int countdown;
  const _ReadyScreen({required this.countdown});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        countdown > 0 ? '$countdown' : 'GO!',
        style: const TextStyle(
          fontSize: 96,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _ExerciseScreen extends StatelessWidget {
  final WorkoutPlayerViewModel viewModel;
  const _ExerciseScreen({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Header
          Text(
            viewModel.currentExercise.exerciseTitle,
            style: const TextStyle(
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Timer
          Text(
            '${viewModel.countdown}s',
            style: const TextStyle(
              fontSize: 80,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Pause and Skip buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: viewModel.pauseWorkout,
                child: const Text('Pause'),
              ),
              ElevatedButton(
                onPressed: viewModel.skipExercise,
                child: const Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RestScreen extends StatelessWidget {
  final WorkoutPlayerViewModel viewModel;
  const _RestScreen({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'REST',
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          Text(
            '${viewModel.countdown}',
            style: const TextStyle(
              fontSize: 80,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (viewModel.nextExercise != null)
            Text(
              'Next: ${viewModel.nextExercise!.exerciseTitle}',
              style: const TextStyle(fontSize: 24, color: Colors.white70),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: viewModel.increaseRestTime,
                child: const Text('+15s'),
              ),
              ElevatedButton(
                onPressed: viewModel.skipRest,
                child: const Text('Skip Rest'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PauseScreen extends StatelessWidget {
  final WorkoutPlayerViewModel viewModel;
  const _PauseScreen({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'PAUSED',
            style: TextStyle(fontSize: 48, color: Colors.white),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: viewModel.resumeWorkout,
            child: const Text('Resume'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Quit'),
          ),
        ],
      ),
    );
  }
}

class _FinishedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Workout Finished!',
            style: TextStyle(fontSize: 32, color: Colors.white),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }
}
