import 'package:ai_fitness_app/core/viewmodels/category_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/search/level_badge.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LevelSection extends StatelessWidget {
  const LevelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Level',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            LevelBadge(
              level: 'Beginner',
              color: Colors.green,
              onTap: () => _onLevelSelected(context, 'beginner'),
            ),
            const SizedBox(width: 16),
            LevelBadge(
              level: 'Intermediate',
              color: Colors.orange,
              onTap: () => _onLevelSelected(context, 'intermediate'),
            ),
            const SizedBox(width: 16),
            LevelBadge(
              level: 'Advanced',
              color: Colors.red,
              onTap: () => _onLevelSelected(context, 'advanced'),
            ),
          ],
        ),
      ],
    );
  }

  void _onLevelSelected(BuildContext context, String level) async {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);
    final workouts = await viewModel.getWorkoutsByLevel(level);

    if (context.mounted) {
      context.push('/results', extra: {'title': level, 'workouts': workouts});
    }
  }
}
