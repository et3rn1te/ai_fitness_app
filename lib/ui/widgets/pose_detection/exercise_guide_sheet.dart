// widgets/pose_detection/exercise_guide_sheet.dart
import 'package:flutter/material.dart';

class ExerciseGuideSheet extends StatelessWidget {
  final String exercise;

  const ExerciseGuideSheet({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$exercise Guide',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            _getExerciseInstructions(exercise),
            style: const TextStyle(height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  String _getExerciseInstructions(String exercise) {
    switch (exercise) {
      case 'Squat':
        return '1. Stand with feet shoulder-width apart\n'
            '2. Keep your back straight\n'
            '3. Lower your body until thighs are parallel\n'
            '4. Push through heels to return to start';
      case 'Push-up':
        return '1. Start in plank position\n'
            '2. Lower body until chest nearly touches floor\n'
            '3. Keep core engaged throughout\n'
            '4. Push back up to starting position';
      case 'Plank':
        return '1. Start in forearm plank position\n'
            '2. Keep body in straight line\n'
            '3. Engage core and glutes\n'
            '4. Hold position for desired duration';
      case 'Lunge':
        return '1. Step forward with one leg\n'
            '2. Lower hips until both knees at 90°\n'
            '3. Keep front knee over ankle\n'
            '4. Push back to starting position';
      case 'Jumping Jack':
        return '1. Start with feet together, arms at sides\n'
            '2. Jump feet apart while raising arms\n'
            '3. Jump back to starting position\n'
            '4. Maintain steady rhythm';
      default:
        return 'No instructions available for this exercise.';
    }
  }
}
