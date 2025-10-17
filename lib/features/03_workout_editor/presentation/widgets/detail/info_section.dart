import 'package:flutter/material.dart';
import 'info_chip.dart'; // Import widget InfoChip

class InfoSection extends StatelessWidget {
  final String title;
  final int? duration;
  final int? totalExercises;

  const InfoSection({
    super.key,
    required this.title,
    this.duration,
    required this.totalExercises,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              InfoChip(
                icon: Icons.timer,
                label: '${duration ?? 0} mins',
                color: Colors.blue,
              ),
              const SizedBox(width: 12),
              InfoChip(
                icon: Icons.fitness_center,
                label: '$totalExercises exercises',
                color: Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
