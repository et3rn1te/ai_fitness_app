import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String duration;
  final int energyLevel; // 1-3 representing easy, medium, hard
  final String? imageUrl;
  final VoidCallback? onTap;

  const ExerciseCard({
    super.key,
    required this.name,
    required this.duration,
    required this.energyLevel,
    this.imageUrl,
    this.onTap,
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
        onTap: onTap,
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
