// widgets/pose_detection/exercise_info_overlay.dart
import 'package:flutter/material.dart';
import 'stat_card.dart';

class ExerciseInfoOverlay extends StatelessWidget {
  final String selectedExercise;
  final int repCount;
  final double formScore;
  final Function(String) onExerciseChanged;

  const ExerciseInfoOverlay({
    super.key,
    required this.selectedExercise,
    required this.repCount,
    required this.formScore,
    required this.onExerciseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: 16,
      right: 16,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(25),
            ),
            child: DropdownButton<String>(
              value: selectedExercise,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              items: ['Squat', 'Push-up', 'Plank', 'Lunge', 'Jumping Jack']
                  .map(
                    (exercise) => DropdownMenuItem(
                      value: exercise,
                      child: Text(exercise),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  onExerciseChanged(value);
                }
              },
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  label: 'Reps',
                  value: repCount.toString(),
                  icon: Icons.repeat,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  label: 'Form Score',
                  value: '${(formScore * 100).toInt()}%',
                  icon: Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
