import 'package:ai_fitness_app/screens/training/workout_player_screen.dart';
import 'package:flutter/material.dart';

class WorkoutCard extends StatelessWidget {
  final String name;
  final String duration;
  final int energyLevel;
  final String? imageUrl;
  // Remove the onTap parameter since we'll handle navigation internally

  const WorkoutCard({
    super.key,
    required this.name,
    required this.duration,
    required this.energyLevel,
    this.imageUrl,
  });

  Widget _buildEnergyIndicator() {
    return Row(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 2),
          child: Icon(
            Icons.flash_on,
            size: 16,
            color: index < energyLevel
                ? Colors.amber
                : Colors.grey.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Option 1: Using GoRouter (Recommended if you're using GoRouter)
          // context.go('/workout-player');

          // Option 2: Using Navigator (If you're using traditional navigation)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WorkoutPlayerScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Exercise Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: Theme.of(context).colorScheme.primaryContainer,
                        child: Icon(
                          Icons.fitness_center,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
              ),
              const SizedBox(width: 16),
              // Exercise Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      duration,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildEnergyIndicator(),
                  ],
                ),
              ),
              // Arrow indicator
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
