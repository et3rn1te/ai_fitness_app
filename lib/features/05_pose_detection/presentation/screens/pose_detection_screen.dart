import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/bottom_control.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/camera_preview.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/exercise_guide_sheet.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/exercise_info_overlay.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/form_feedback_overlay.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/history_bottom_sheet.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/widgets/top_controls.dart';
import 'package:flutter/material.dart';

class PoseDetectionScreen extends StatefulWidget {
  const PoseDetectionScreen({super.key});

  @override
  State<PoseDetectionScreen> createState() => _PoseDetectionScreenState();
}

class _PoseDetectionScreenState extends State<PoseDetectionScreen> {
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
