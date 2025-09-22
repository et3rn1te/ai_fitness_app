import 'package:flutter/material.dart';

class WorkoutStreak extends StatelessWidget {
  final int streakDays;
  final List<bool> weeklyProgress;

  const WorkoutStreak({
    super.key,
    required this.streakDays,
    required this.weeklyProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Streak',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '$streakDays days',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                return _DayIndicator(
                  day: ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                  isCompleted: weeklyProgress[index],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _DayIndicator extends StatelessWidget {
  final String day;
  final bool isCompleted;

  const _DayIndicator({required this.day, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted
                ? Theme.of(context).primaryColor
                : Colors.grey.withOpacity(0.2),
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.fitness_center,
            size: 20,
            color: isCompleted ? Colors.white : Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(day),
      ],
    );
  }
}
