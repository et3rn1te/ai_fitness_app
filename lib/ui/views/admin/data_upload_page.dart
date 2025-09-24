import 'package:flutter/material.dart';
import 'package:ai_fitness_app/services/data_upload_service.dart';

class DataUploadPage extends StatelessWidget {
  DataUploadPage({super.key}); // Removed 'const'

  final DataUploadService _uploadService = DataUploadService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Data')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _uploadService.uploadWorkouts();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Workouts uploaded!')),
                  );
                }
              },
              child: const Text('Upload Workouts'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _uploadService.uploadCategories();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Categories uploaded!')),
                  );
                }
              },
              child: const Text('Upload Categories'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _uploadService.uploadBodyParts();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Body Parts uploaded!')),
                  );
                }
              },
              child: const Text('Upload Body Parts'),
            ),
          ],
        ),
      ),
    );
  }
}
