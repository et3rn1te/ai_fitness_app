import 'package:ai_fitness_app/core/repositories/category_repository.dart';
import 'package:ai_fitness_app/core/viewmodels/category_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/search/body_focus_section.dart';
import 'package:ai_fitness_app/ui/widgets/search/category_search_appbar.dart';
import 'package:ai_fitness_app/ui/widgets/search/duration_section.dart';
import 'package:ai_fitness_app/ui/widgets/search/level_section.dart';
import 'package:ai_fitness_app/ui/widgets/search/workout_type_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CategoryViewModel(CategoryRepository()),
        ),
      ],
      child: const CategoryPageContent(),
    );
  }
}

class CategoryPageContent extends StatelessWidget {
  const CategoryPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CategorySearchAppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyFocusSection(),
              SizedBox(height: 32),
              WorkoutTypeSection(),
              SizedBox(height: 32),
              LevelSection(),
              SizedBox(height: 32),
              DurationSection(),
            ],
          ),
        ),
      ),
    );
  }
}
