// widgets/pose_detection/bottom_controls.dart
import 'package:flutter/material.dart';
import 'quick_action_button.dart';

class BottomControls extends StatelessWidget {
  final bool isAnalyzing;
  final VoidCallback onToggleAnalysis;
  final VoidCallback onShowHistory;
  final VoidCallback onShowTutorial;
  final VoidCallback onShowSettings;

  const BottomControls({
    super.key,
    required this.isAnalyzing,
    required this.onToggleAnalysis,
    required this.onShowHistory,
    required this.onShowTutorial,
    required this.onShowSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
          ),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: onToggleAnalysis,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isAnalyzing ? Colors.red : Colors.white,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Icon(
                  isAnalyzing ? Icons.stop : Icons.play_arrow,
                  color: isAnalyzing ? Colors.white : Colors.black,
                  size: 40,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              isAnalyzing ? 'Analyzing...' : 'Tap to start',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                QuickActionButton(
                  icon: Icons.history,
                  label: 'History',
                  onTap: onShowHistory,
                ),
                QuickActionButton(
                  icon: Icons.videocam,
                  label: 'Tutorial',
                  onTap: onShowTutorial,
                ),
                QuickActionButton(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: onShowSettings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
