import 'package:flutter/material.dart';

class WorkoutCardVariant2 extends StatelessWidget {
  final String title;
  final String duration;
  final String level;
  final String imageUrl;
  final VoidCallback? onTap;

  const WorkoutCardVariant2({
    super.key,
    required this.title,
    required this.duration,
    required this.level,
    required this.imageUrl,
    this.onTap,
  });

  Widget _buildEnergyLevel() {
    // Convert level to number of active symbols
    int activeSymbols;
    Color symbolColor;

    switch (level.toLowerCase()) {
      case 'beginner':
        activeSymbols = 1;
        symbolColor = Colors.amber;
        break;
      case 'intermediate':
        activeSymbols = 2;
        symbolColor = Colors.amber;
        break;
      case 'advanced':
        activeSymbols = 3;
        symbolColor = Colors.amber;
        break;
      default:
        activeSymbols = 1;
        symbolColor = Colors.amber;
    }

    return Row(
      children: List.generate(3, (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Icon(
            Icons.bolt,
            size: 20,
            color: index < activeSymbols
                ? symbolColor
                : Colors.grey.withOpacity(0.3),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              // Image section
              SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.fitness_center),
                      );
                    },
                  ),
                ),
              ),
              // Content section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        duration,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      _buildEnergyLevel(),
                    ],
                  ),
                ),
              ),
              // Arrow icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.chevron_right, color: Colors.grey[400]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
