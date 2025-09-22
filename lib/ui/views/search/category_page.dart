import 'package:ai_fitness_app/ui/widgets/search/body_focus_item.dart';
import 'package:ai_fitness_app/ui/widgets/search/duration_item.dart';
import 'package:ai_fitness_app/ui/widgets/search/level_badge.dart';
import 'package:ai_fitness_app/ui/widgets/search/workout_type_item.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  // In your category page when a category is selected
  void _onCategorySelected(BuildContext context, String categoryName) {
    context.push(
      '/results',
      extra: {
        'categoryName': categoryName,
        'workouts': [
          {
            'title': 'Full Body HIIT',
            'duration': '45 min',
            'energyLevel': 3,
            'imageUrl': 'https://example.com/workout1.jpg',
          },
          {
            'title': 'Upper Body Strength',
            'duration': '30 min',
            'energyLevel': 2,
            'imageUrl': 'https://example.com/workout2.jpg',
          },
          {
            'title': 'Core Crusher',
            'duration': '20 min',
            'energyLevel': 2,
            'imageUrl': 'https://example.com/workout3.jpg',
          },
          // Add more workouts...
        ],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
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
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Body Focus Section
              const Text(
                'Body Focus',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    BodyFocusItem(
                      imagePath: 'assets/images/full_body.jpg',
                      name: 'Full Body',
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    BodyFocusItem(
                      imagePath: 'assets/images/abs.jpg',
                      name: 'Abs',
                      onTap: () {},
                    ),
                    // Add more body focus items...
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Workout Type Section
              const Text(
                'Workout Type',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height:
                    180, // Height for 2 rows (adjust based on your item height + spacing)
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      children: [
                        // First Row
                        Row(
                          children: [
                            WorkoutTypeItem(
                              name: 'HIIT',
                              icon: Icons.flash_on,
                              onTap: () => _onCategorySelected(context, 'HIIT'),
                            ),
                            const SizedBox(width: 16),
                            WorkoutTypeItem(
                              name: 'Warm-up',
                              icon: Icons.whatshot,
                              onTap: () =>
                                  _onCategorySelected(context, 'Warm-up'),
                            ),
                            const SizedBox(width: 16),
                            WorkoutTypeItem(
                              name: 'Strength',
                              icon: Icons.fitness_center,
                              onTap: () =>
                                  _onCategorySelected(context, 'Strength'),
                            ),
                            // Add more items...
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Second Row
                        Row(
                          children: [
                            WorkoutTypeItem(
                              name: 'Cardio',
                              icon: Icons.directions_run,
                              onTap: () =>
                                  _onCategorySelected(context, 'Cardio'),
                            ),
                            const SizedBox(width: 16),
                            WorkoutTypeItem(
                              name: 'Flexibility',
                              icon: Icons.accessibility_new,
                              onTap: () =>
                                  _onCategorySelected(context, 'Flexibility'),
                            ),
                            const SizedBox(width: 16),
                            WorkoutTypeItem(
                              name: 'Build Muscle',
                              icon: Icons.sports_gymnastics,
                              onTap: () =>
                                  _onCategorySelected(context, 'Build Muscle'),
                            ),
                            // Add more items...
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Level Section
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
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  LevelBadge(
                    level: 'Intermediate',
                    color: Colors.orange,
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  LevelBadge(
                    level: 'Advanced',
                    color: Colors.red,
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Duration Section
              const Text(
                'Duration',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    DurationItem(minutes: '<4', onTap: () {}),
                    const SizedBox(width: 16),
                    DurationItem(minutes: '5-7', onTap: () {}),
                    const SizedBox(width: 16),
                    DurationItem(minutes: '8-10', onTap: () {}),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
