// widgets/pose_detection/top_controls.dart
import 'package:flutter/material.dart';

class TopControls extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onSwitchCamera;
  final VoidCallback onShowGuide;

  const TopControls({
    super.key,
    required this.onBack,
    required this.onSwitchCamera,
    required this.onShowGuide,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: onBack,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.flip_camera_ios, color: Colors.white),
                  onPressed: onSwitchCamera,
                ),
                IconButton(
                  icon: const Icon(Icons.info_outline, color: Colors.white),
                  onPressed: onShowGuide,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
