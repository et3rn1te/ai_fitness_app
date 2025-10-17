import 'package:flutter/material.dart';

class StartWorkoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const StartWorkoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      right: 20,
      bottom: 20,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Theme.of(
            context,
          ).primaryColor, // Sử dụng màu chính của theme
          foregroundColor: Colors.white,
        ),
        child: const Text(
          'Start Workout',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
