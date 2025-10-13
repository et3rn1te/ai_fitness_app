// screens/pose_detection_page.dart
import 'package:ai_fitness_app/features/main/widgets/pose/bottom_control.dart';
import 'package:ai_fitness_app/features/main/widgets/pose/camera_preview.dart';
import 'package:ai_fitness_app/features/main/widgets/pose/exercise_guide_sheet.dart';
import 'package:ai_fitness_app/features/main/widgets/pose/exercise_info_overlay.dart';
import 'package:ai_fitness_app/features/main/widgets/pose/form_feedback_overlay.dart';
import 'package:ai_fitness_app/features/main/widgets/pose/history_bottom_sheet.dart';
import 'package:ai_fitness_app/features/main/widgets/pose/top_controls.dart';
import 'package:flutter/material.dart';

class PoseDetectionPage extends StatefulWidget {
  const PoseDetectionPage({super.key});

  @override
  State<PoseDetectionPage> createState() => _PoseDetectionPageState();
}

class _PoseDetectionPageState extends State<PoseDetectionPage> {
  bool _isAnalyzing = false;
  String _selectedExercise = 'Squat';
  int _repCount = 0;
  double _formScore = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            const CameraPreview(),

            TopControls(
              onBack: () => Navigator.pop(context),
              onSwitchCamera: () {
                // Switch camera logic
              },
              onShowGuide: () => _showExerciseGuide(),
            ),

            ExerciseInfoOverlay(
              selectedExercise: _selectedExercise,
              repCount: _repCount,
              formScore: _formScore,
              onExerciseChanged: (exercise) {
                setState(() {
                  _selectedExercise = exercise;
                  _repCount = 0;
                });
              },
            ),

            BottomControls(
              isAnalyzing: _isAnalyzing,
              onToggleAnalysis: () {
                setState(() {
                  _isAnalyzing = !_isAnalyzing;
                  if (_isAnalyzing) {
                    _simulateAnalysis();
                  }
                });
              },
              onShowHistory: () => _showHistoryBottomSheet(),
              onShowTutorial: () => _showTutorial(),
              onShowSettings: () => _showPoseSettings(),
            ),

            if (_isAnalyzing) FormFeedbackOverlay(formScore: _formScore),
          ],
        ),
      ),
    );
  }

  void _simulateAnalysis() {
    Future.delayed(const Duration(seconds: 2), () {
      if (_isAnalyzing) {
        setState(() {
          _repCount++;
          _formScore = (0.5 + (0.5 * (_repCount % 3) / 2));
        });
        _simulateAnalysis();
      }
    });
  }

  void _showExerciseGuide() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => ExerciseGuideSheet(exercise: _selectedExercise),
    );
  }

  void _showHistoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const HistoryBottomSheet(),
    );
  }

  void _showTutorial() {
    // Show tutorial implementation
  }

  void _showPoseSettings() {
    // Show settings implementation
  }
}
