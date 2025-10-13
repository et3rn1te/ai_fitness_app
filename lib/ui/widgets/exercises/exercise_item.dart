import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  final String name;
  final String count; // This can be either duration (00:30) or reps (x10)
  final String? animationUrl; // Changed to be nullable to match server data
  final VoidCallback onReplace;

  const ExerciseItem({
    super.key,
    required this.name,
    required this.count,
    this.animationUrl, // Updated constructor
    required this.onReplace,
  });

  @override
  Widget build(BuildContext context) {
    // Helper to decide whether we have a valid URL to display
    final bool hasValidUrl = animationUrl != null && animationUrl!.isNotEmpty;

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
              // Conditionally build the image or show a placeholder
              child: hasValidUrl
                  ? Image.network(
                      animationUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        // This will catch 404s or other network errors
                        return const Icon(
                          Icons.fitness_center,
                          color: Colors.grey,
                        );
                      },
                    )
                  : const Icon(Icons.fitness_center, color: Colors.grey),
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
