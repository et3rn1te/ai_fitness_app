import 'package:flutter/material.dart';

class WorkoutStreakCalendar extends StatelessWidget {
  final List<DateTime> workoutDays;
  final int currentStreak;

  const WorkoutStreakCalendar({
    super.key,
    required this.workoutDays,
    required this.currentStreak,
  });

  @override
  Widget build(BuildContext context) {
    final currentDate = DateTime.now();
    final startDate = currentDate.subtract(const Duration(days: 30));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Streak information
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    currentStreak.toString(),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Text(
                    'Day Streak',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Calendar grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
            itemCount: 30, // Show last 30 days
            itemBuilder: (context, index) {
              final date = startDate.add(Duration(days: index));
              final isWorkoutDay = workoutDays.any(
                (workoutDate) =>
                    workoutDate.year == date.year &&
                    workoutDate.month == date.month &&
                    workoutDate.day == date.day,
              );

              return Container(
                decoration: BoxDecoration(
                  color: isWorkoutDay
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                      : Theme.of(
                          context,
                        ).colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                  border: date.day == currentDate.day
                      ? Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        )
                      : null,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isWorkoutDay
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                      fontWeight: isWorkoutDay
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
