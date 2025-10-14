// widgets/pose_detection/form_feedback_overlay.dart
import 'package:flutter/material.dart';

class FormFeedbackOverlay extends StatelessWidget {
  final double formScore;

  const FormFeedbackOverlay({super.key, required this.formScore});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 200,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _getColor(),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(_getIcon(), color: Colors.white),
              const SizedBox(width: 8),
              Text(
                _getMessage(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (formScore > 0.8) return Colors.green.withOpacity(0.9);
    if (formScore > 0.5) return Colors.orange.withOpacity(0.9);
    return Colors.red.withOpacity(0.9);
  }

  IconData _getIcon() {
    if (formScore > 0.8) return Icons.check_circle;
    if (formScore > 0.5) return Icons.warning;
    return Icons.error;
  }

  String _getMessage() {
    if (formScore > 0.8) return 'Perfect form!';
    if (formScore > 0.5) return 'Keep your back straight';
    return 'Adjust your posture';
  }
}
