import 'package:ai_fitness_app/core/models/workout_model.dart';
import 'package:ai_fitness_app/core/viewmodels/exercise_view_model.dart';
import 'package:ai_fitness_app/ui/views/training/exercise_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExerciseListPage extends StatelessWidget {
  final WorkoutModel workout;

  const ExerciseListPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseViewModel(workout),
      child: const ExerciseListView(),
    );
  }
}
