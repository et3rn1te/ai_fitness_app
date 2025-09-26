import 'package:ai_fitness_app/core/viewmodels/category_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/search/duration_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DurationSection extends StatelessWidget {
  const DurationSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Duration',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DurationItem(
                minutes: '<4',
                onTap: () => _onDurationSelected(context, '<4'),
              ),
              const SizedBox(width: 16),
              DurationItem(
                minutes: '5-7',
                onTap: () => _onDurationSelected(context, '5-7'),
              ),
              const SizedBox(width: 16),
              DurationItem(
                minutes: '8-10',
                onTap: () => _onDurationSelected(context, '8-10'),
              ),
              const SizedBox(width: 16),
              DurationItem(
                minutes: '>10',
                onTap: () => _onDurationSelected(context, '>10'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _onDurationSelected(BuildContext context, String duration) async {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);
    final workouts = await viewModel.getWorkoutsByDuration(duration);

    if (context.mounted) {
      context.push(
        '/results',
        extra: {'title': '$duration mins', 'workouts': workouts},
      );
    }
  }
}
