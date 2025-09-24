import 'package:ai_fitness_app/core/models/body_part_model.dart';
import 'package:ai_fitness_app/core/viewmodels/category_view_model.dart';
import 'package:ai_fitness_app/ui/widgets/search/body_focus_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BodyFocusSection extends StatelessWidget {
  const BodyFocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CategoryViewModel>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Body Focus',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: StreamBuilder<List<BodyPartModel>>(
            stream: viewModel.getBodyPartsStream(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final bodyParts = snapshot.data ?? [];

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bodyParts.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final bodyPart = bodyParts[index];
                  return BodyFocusItem(
                    imagePath: bodyPart.imageUrl,
                    name: bodyPart.name,
                    onTap: () => _onBodyPartSelected(context, bodyPart),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _onBodyPartSelected(BuildContext context, BodyPartModel bodyPart) {
    // Handle body part selection
  }
}
