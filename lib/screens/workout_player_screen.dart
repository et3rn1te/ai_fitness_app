import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_action_button.dart';

class WorkoutPlayerScreen extends StatelessWidget {
  const WorkoutPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(scaffoldBackgroundColor: Colors.black),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            // Black background as placeholder for camera feed
            Container(color: Colors.black),

            // UI Overlay
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),
                    // Exercise name
                    const Text(
                      'Squats',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    // Rep counter
                    Text(
                      '0',
                      style: TextStyle(
                        color: AppTheme.neonGreen,
                        fontSize: 120,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    // End workout button
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: PrimaryActionButton(
                        text: 'End Workout',
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icons.stop_circle_outlined,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
