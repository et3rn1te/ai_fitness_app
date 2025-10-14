import 'package:ai_fitness_app/data/services/category_api_service.dart';
import 'package:ai_fitness_app/data/models/categories/category_model.dart';
import 'package:flutter/material.dart';

class ExerciseFilterDialog extends StatefulWidget {
  final Map<String, List<dynamic>> initialFilters;

  const ExerciseFilterDialog({super.key, required this.initialFilters});

  @override
  State<ExerciseFilterDialog> createState() => _ExerciseFilterDialogState();
}

class _ExerciseFilterDialogState extends State<ExerciseFilterDialog> {
  final CategoryApiService _apiService = CategoryApiService();
  late Map<String, List<dynamic>> _selectedFilters;

  @override
  void initState() {
    super.initState();
    // Deep copy the map of lists to avoid modifying the original
    _selectedFilters = widget.initialFilters.map(
      (key, value) => MapEntry(key, List.from(value)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // ... same container setup ...
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Exercises',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '150 exercises',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],
          ),
          const Divider(height: 24),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection<Category>(
                    'Focus Area',
                    _apiService.fetchBodyPartCategories(),
                    'bodyPartIds',
                    (item) => item.id,
                    (item) => item.name,
                  ),
                  _buildSection<String>(
                    'Difficulty',
                    Future.value(['EASY', 'MEDIUM', 'HARD']),
                    'difficulties',
                    (item) => item,
                    (item) => item,
                  ),
                  _buildSection<Category>(
                    'Type',
                    _apiService.fetchExerciseTypes(),
                    'typeIds',
                    (item) => item.id,
                    (item) => item.name,
                  ),
                  _buildSection<Category>(
                    'Equipment',
                    _apiService.fetchEquipment(),
                    'equipmentIds',
                    (item) => item.id,
                    (item) => item.name,
                  ),
                ],
              ),
            ),
          ),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(_selectedFilters),
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection<T>(
    String title,
    Future<List<T>> future,
    String filterKey,
    Function(T) getId,
    Function(T) getName,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<T>>(
          future: future,
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              );
            final items = snapshot.data!;
            // Ensure the key exists in the map
            _selectedFilters.putIfAbsent(filterKey, () => []);

            return Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: items.map((item) {
                final id = getId(item);
                final name = getName(item);
                // Check if the current item's ID is in the list of selected IDs for this category
                final isSelected = _selectedFilters[filterKey]!.contains(id);

                return FilterChip(
                  label: Text(name),
                  selectedColor: Theme.of(
                    context,
                  ).primaryColor.withOpacity(0.2),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      // --- UPDATED MULTI-SELECT LOGIC ---
                      if (selected) {
                        _selectedFilters[filterKey]!.add(id);
                      } else {
                        _selectedFilters[filterKey]!.remove(id);
                      }
                    });
                  },
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
