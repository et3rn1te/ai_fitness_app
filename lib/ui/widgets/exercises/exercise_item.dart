import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final String name;
  final String count; // This can be either duration (00:30) or reps (x10)
  final String animationUrl;
  final VoidCallback onReplace;

  const ExerciseItem({
    super.key,
    required this.name,
    required this.count,
    required this.animationUrl,
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          // Reorder handle
          const Icon(Icons.drag_handle, color: Colors.grey, size: 24),
          const SizedBox(width: 12),

          // Exercise animation/image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[200],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                animationUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.fitness_center);
                },
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Exercise details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  count,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),

          // Replace button
          IconButton(icon: const Icon(Icons.swap_horiz), onPressed: onReplace),
        ],
      ),
    );
  }
}
