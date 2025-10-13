import 'package:ai_fitness_app/features/workouts/viewmodels/category_viewmodel.dart';
import 'package:ai_fitness_app/features/workouts/widgets/body_focus_item.dart';
import 'package:ai_fitness_app/features/workouts/widgets/duration_item.dart';
import 'package:ai_fitness_app/features/workouts/widgets/level_badge.dart';
import 'package:ai_fitness_app/features/workouts/widgets/workout_type_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    // Tell the ViewModel to start loading its data as soon as the page is ready.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryViewModel>(context, listen: false).loadCategories();
    });
  }

  void _navigateToResults(String title, Map<String, String> queryParams) {
    context.push(
      Uri(
        path: '/results',
        queryParameters: {'title': title, ...queryParams},
      ).toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The Consumer widget rebuilds its children whenever the ViewModel changes.
    return Consumer<CategoryViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: SafeArea(child: _buildAppBar()),
          ),
          body: _buildBody(viewModel), // Pass the ViewModel to the body builder
        );
      },
    );
  }

  Widget _buildBody(CategoryViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.errorMessage != null) {
      return Center(child: Text(viewModel.errorMessage!));
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Body Focus'),
            const SizedBox(height: 16),
            _buildBodyFocusSection(viewModel), // Pass ViewModel down
            const SizedBox(height: 32),
            _buildSectionTitle('Workout Type'),
            const SizedBox(height: 16),
            _buildWorkoutTypeSection(viewModel), // Pass ViewModel down
            const SizedBox(height: 32),
            _buildSectionTitle('Level'),
            const SizedBox(height: 16),
            _buildLevelSection(),
            const SizedBox(height: 32),
            _buildSectionTitle('Duration'),
            const SizedBox(height: 16),
            _buildDurationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    /* ... Same as before ... */
    return Container();
  }

  Widget _buildSectionTitle(String title) {
    /* ... Same as before ... */
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // This widget is now "dumb" and builds from the ViewModel's state
  Widget _buildBodyFocusSection(CategoryViewModel viewModel) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.bodyParts.length,
        separatorBuilder: (context, index) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final bodyPart = viewModel.bodyParts[index];
          return BodyFocusItem(
            imagePath: bodyPart.imageUrl ?? 'assets/images/placeholder.jpg',
            name: bodyPart.name,
            onTap: () => _navigateToResults(bodyPart.name, {
              'bodyPartId': bodyPart.id.toString(),
            }),
          );
        },
      ),
    );
  }

  // This widget is also now "dumb"
  Widget _buildWorkoutTypeSection(CategoryViewModel viewModel) {
    const iconMap = {
      'HIIT': Icons.flash_on,
      'Strength': Icons.fitness_center,
      'Cardio': Icons.directions_run,
    };
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: viewModel.workoutTypes.map((type) {
        return WorkoutTypeItem(
          name: type.name,
          icon: iconMap[type.name] ?? Icons.fitness_center,
          onTap: () => _navigateToResults(type.name, {
            'workoutTypeId': type.id.toString(),
          }),
        );
      }).toList(),
    );
  }

  Widget _buildLevelSection() {
    /* ... Same as before ... */
    return Row(
      children: [
        LevelBadge(
          level: 'Beginner',
          color: Colors.green,
          onTap: () => _navigateToResults('Beginner', {'level': 'BEGINNER'}),
        ),
        const SizedBox(width: 16),
        LevelBadge(
          level: 'Intermediate',
          color: Colors.orange,
          onTap: () =>
              _navigateToResults('Intermediate', {'level': 'INTERMEDIATE'}),
        ),
        const SizedBox(width: 16),
        LevelBadge(
          level: 'Advanced',
          color: Colors.red,
          onTap: () => _navigateToResults('Advanced', {'level': 'ADVANCED'}),
        ),
      ],
    );
  }

  Widget _buildDurationSection() {
    /* ... Same as before ... */
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DurationItem(
            minutes: '<4',
            onTap: () =>
                _navigateToResults('Under 4 Mins', {'durationRange': '<4'}),
          ),
          const SizedBox(width: 16),
          DurationItem(
            minutes: '5-7',
            onTap: () =>
                _navigateToResults('5-7 Mins', {'durationRange': '5-7'}),
          ),
          const SizedBox(width: 16),
          DurationItem(
            minutes: '8-10',
            onTap: () =>
                _navigateToResults('8-10 Mins', {'durationRange': '8-10'}),
          ),
        ],
      ),
    );
  }
}
