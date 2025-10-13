import 'dart:async';
import 'dart:collection';
import 'package:ai_fitness_app/core/api/category_api_service.dart';
import 'package:ai_fitness_app/core/api/exercise_api_service.dart';
import 'package:ai_fitness_app/core/categories/category_model.dart';
import 'package:ai_fitness_app/core/exercises/exercise_summary_model.dart';
import 'package:ai_fitness_app/ui/views/exercises/exercise_filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

class AddExercisesDialog extends StatefulWidget {
  const AddExercisesDialog({super.key});

  @override
  State<AddExercisesDialog> createState() => _AddExercisesDialogState();
}

class _AddExercisesDialogState extends State<AddExercisesDialog> {
  final ExerciseApiService _exerciseApiService = ExerciseApiService();
  final CategoryApiService _categoryApiService = CategoryApiService();
  final TextEditingController _searchController = TextEditingController();

  // State for fetched exercises
  List<ExerciseSummary> _exercises = [];
  Map<String, List<ExerciseSummary>> _groupedExercises = {};
  final Set<int> _selectedExerciseIds = {};

  // State for filters
  Map<String, List<dynamic>> _appliedFilters = {};
  int _totalExerciseCount = 0;
  bool _isLoading = true;

  // State for filter categories
  List<Category> _allBodyParts = [];
  List<Category> _allExerciseTypes = [];
  List<Category> _allEquipment = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadInitialData() async {
    await Future.wait([_fetchAndGroupExercises(), _fetchFilterCategories()]);
  }

  Future<void> _fetchFilterCategories() async {
    try {
      _allBodyParts = await _categoryApiService.fetchBodyPartCategories();
      _allExerciseTypes = await _categoryApiService.fetchExerciseTypes();
      _allEquipment = await _categoryApiService.fetchEquipment();
    } catch (e) {
      // Handle error gracefully
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Failed to load filters: $e")));
      }
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _fetchAndGroupExercises();
    });
  }

  Future<void> _fetchAndGroupExercises() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final queryParams = <String, String>{};
      _appliedFilters.forEach((key, valueList) {
        if (valueList.isNotEmpty) {
          queryParams[key] = valueList.join(',');
        }
      });
      if (_searchController.text.isNotEmpty) {
        queryParams['keyword'] = _searchController.text;
      }

      if (queryParams.isEmpty) {
        _exercises = await _exerciseApiService.fetchAllExercises();
        if (_totalExerciseCount == 0 && mounted) {
          setState(() {
            _totalExerciseCount = _exercises.length;
          });
        }
      } else {
        _exercises = await _exerciseApiService.searchExercises(queryParams);
      }
      _groupExercises();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _groupExercises() {
    final grouped = SplayTreeMap<String, List<ExerciseSummary>>();
    for (var exercise in _exercises) {
      grouped
          .putIfAbsent(exercise.title[0].toUpperCase(), () => [])
          .add(exercise);
    }
    setState(() {
      _groupedExercises = grouped;
    });
  }

  void _showFilterPopup() async {
    final result = await showModalBottomSheet<Map<String, List<dynamic>>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ExerciseFilterDialog(initialFilters: _appliedFilters),
    );
    if (result != null) {
      result.removeWhere((key, value) => value.isEmpty);
      setState(() {
        _appliedFilters = result;
      });
      _fetchAndGroupExercises();
    }
  }

  void _clearFilters() {
    setState(() {
      _appliedFilters.clear();
    });
    _fetchAndGroupExercises();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              _buildHeader(),
              _buildFilterSection(),
              _buildSearchField(),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _buildGroupedList(scrollController),
              ),
              _buildAddButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterSection() {
    bool isFiltered = _appliedFilters.isNotEmpty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ActionChip(
                label: Text(
                  isFiltered
                      ? 'Filtered (${_exercises.length})'
                      : 'All Areas ($_totalExerciseCount)',
                ),
                onPressed: _showFilterPopup,
                avatar: isFiltered ? null : const Icon(Icons.tune, size: 16),
                backgroundColor: isFiltered
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.grey[200],
              ),
              if (isFiltered) ...[
                const Spacer(),
                TextButton(
                  onPressed: _clearFilters,
                  child: const Text('Clear'),
                ),
              ],
            ],
          ),
          if (isFiltered) ...[
            const SizedBox(height: 8),
            Wrap(spacing: 8.0, children: _buildFilterChips()),
          ],
        ],
      ),
    );
  }

  List<Widget> _buildFilterChips() {
    final List<Widget> chips = [];
    _appliedFilters.forEach((key, valueList) {
      List<dynamic> sourceList;
      switch (key) {
        case 'bodyPartIds':
          sourceList = _allBodyParts;
          break;
        case 'typeIds':
          sourceList = _allExerciseTypes;
          break;
        case 'equipmentIds':
          sourceList = _allEquipment;
          break;
        default:
          sourceList = [];
      }

      for (var id in valueList) {
        final name = (key == 'difficulties')
            ? id.toString()
            : sourceList
                  .firstWhere(
                    (e) => e.id == id,
                    orElse: () => Category(id: 0, name: 'Unknown'),
                  )
                  .name;

        chips.add(
          Chip(
            label: Text(name),
            onDeleted: () {
              setState(() {
                _appliedFilters[key]?.remove(id);
                if (_appliedFilters[key]!.isEmpty) _appliedFilters.remove(key);
              });
              _fetchAndGroupExercises();
            },
          ),
        );
      }
    });
    return chips;
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Add Exercises",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search exercises",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  Widget _buildGroupedList(ScrollController scrollController) {
    if (_groupedExercises.isEmpty) {
      return const Center(
        child: Text("No exercises match your search or filter."),
      );
    }
    return ListView.builder(
      controller: scrollController,
      itemCount: _groupedExercises.keys.length,
      itemBuilder: (context, index) {
        final letter = _groupedExercises.keys.elementAt(index);
        final exercises = _groupedExercises[letter]!;
        return StickyHeader(
          header: Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            alignment: Alignment.centerLeft,
            child: Text(
              letter,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          content: Column(
            children: exercises.map((exercise) {
              final isSelected = _selectedExerciseIds.contains(exercise.id);
              return CheckboxListTile(
                title: Text(exercise.title),
                subtitle: Text(exercise.displayValue),
                value: isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedExerciseIds.add(exercise.id);
                    } else {
                      _selectedExerciseIds.remove(exercise.id);
                    }
                  });
                },
                secondary: CircleAvatar(
                  child: const Icon(Icons.fitness_center),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: _selectedExerciseIds.isEmpty
            ? null
            : () => Navigator.of(context).pop(_selectedExerciseIds.toList()),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Text('Add (${_selectedExerciseIds.length})'),
      ),
    );
  }
}
