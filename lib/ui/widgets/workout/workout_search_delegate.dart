import 'package:ai_fitness_app/ui/widgets/workout/workout_card_2.dart';
import 'package:flutter/material.dart';

class WorkoutSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return ListView.builder(
      itemCount: 5, // Replace with actual search results
      itemBuilder: (context, index) {
        return WorkoutCardVariant2(
          title: 'Search Result $index',
          duration: '30 min',
          energyLevel: 2,
          imageUrl: 'https://example.com/workout$index.jpg',
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.fitness_center),
          title: Text('Suggested Workout $index'),
          onTap: () {
            query = 'Suggested Workout $index';
            showResults(context);
          },
        );
      },
    );
  }
}
