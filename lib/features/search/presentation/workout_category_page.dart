import 'package:ai_fitness_app/data/remote/category_api_service.dart';
import 'package:ai_fitness_app/data/models/categories/body_part_model.dart';
import 'package:ai_fitness_app/data/models/categories/category_model.dart';
import 'package:ai_fitness_app/features/search/widgets/body_focus_item.dart';
import 'package:ai_fitness_app/features/search/widgets/duration_item.dart';
import 'package:ai_fitness_app/features/search/widgets/level_badge.dart';
import 'package:ai_fitness_app/features/search/widgets/workout_type_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutCategoryPage extends StatefulWidget {
  const WorkoutCategoryPage({super.key});

  @override
  State<WorkoutCategoryPage> createState() => _WorkoutCategoryPageState();
}

class _WorkoutCategoryPageState extends State<WorkoutCategoryPage> {
  final CategoryApiService _apiService = CategoryApiService();
  late Future<List<BodyPart>> _futureBodyParts;
  late Future<List<Category>> _futureWorkoutTypes;

  @override
  void initState() {
    super.initState();
    _futureBodyParts = _apiService.fetchBodyPartsWithImage();
    _futureWorkoutTypes = _apiService.fetchWorkoutTypes();
  }

  // Helper to navigate to results page with a specific filter
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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(child: _buildAppBar()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Body Focus'),
              const SizedBox(height: 16),
              _buildBodyFocusSection(),
              const SizedBox(height: 32),
              _buildSectionTitle('Workout Type'),
              const SizedBox(height: 16),
              _buildWorkoutTypeSection(),
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
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Search workouts...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                onSubmitted: (value) =>
                    _navigateToResults('Search: "$value"', {'keyword': value}),
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBodyFocusSection() {
    return SizedBox(
      height: 120,
      child: FutureBuilder<List<BodyPart>>(
        future: _futureBodyParts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}'));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text('No categories found.'));

          final bodyParts = snapshot.data!;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: bodyParts.length,
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final bodyPart = bodyParts[index];
              return BodyFocusItem(
                imagePath: bodyPart.imageUrl ?? 'assets/images/placeholder.jpg',
                name: bodyPart.name,
                onTap: () => _navigateToResults(bodyPart.name, {
                  'bodyPartId': bodyPart.id.toString(),
                }),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildWorkoutTypeSection() {
    return FutureBuilder<List<Category>>(
      future: _futureWorkoutTypes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const Center(child: CircularProgressIndicator());
        if (snapshot.hasError)
          return Center(child: Text('Error: ${snapshot.error}'));
        if (!snapshot.hasData || snapshot.data!.isEmpty)
          return const Center(child: Text('No types found.'));

        final workoutTypes = snapshot.data!;
        return Wrap(
          spacing: 16.0,
          runSpacing: 16.0,
          children: workoutTypes.map((type) {
            // A simple map to get an icon for a type name
            const iconMap = {
              'HIIT': Icons.flash_on,
              'Build Muscle': Icons.fitness_center,
              'Cardio': Icons.directions_run,
            };
            return WorkoutTypeItem(
              name: type.name,
              icon: iconMap[type.name] ?? Icons.help_outline, // Default icon
              onTap: () => _navigateToResults(type.name, {
                'workoutTypeId': type.id.toString(),
              }),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildLevelSection() {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          DurationItem(
            minutes: '<4',
            onTap: () => _navigateToResults('Under 4 Mins', {
              'durationRange': 'LESS_THAN_4',
            }),
          ),
          const SizedBox(width: 16),
          DurationItem(
            minutes: '5-7',
            onTap: () => _navigateToResults('5-7 Mins', {
              'durationRange': 'BETWEEN_5_AND_7',
            }),
          ),
          const SizedBox(width: 16),
          DurationItem(
            minutes: '8-10',
            onTap: () => _navigateToResults('8-10 Mins', {
              'durationRange': 'BETWEEN_8_AND_10',
            }),
          ),
          DurationItem(
            minutes: '>10',
            onTap: () => _navigateToResults('>10 Mins', {
              'durationRange': 'GREATER_THAN_10',
            }),
          ),
        ],
      ),
    );
  }
}
