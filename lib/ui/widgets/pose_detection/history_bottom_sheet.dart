// widgets/pose_detection/history_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'history_item.dart';

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Sessions',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          HistoryItem(
            date: 'Today',
            exercise: 'Squats',
            reps: '15 reps',
            score: '85%',
          ),
          HistoryItem(
            date: 'Yesterday',
            exercise: 'Push-ups',
            reps: '20 reps',
            score: '92%',
          ),
          HistoryItem(
            date: '2 days ago',
            exercise: 'Plank',
            reps: '60 sec',
            score: '78%',
          ),
        ],
      ),
    );
  }
}
