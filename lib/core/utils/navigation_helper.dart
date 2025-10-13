import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void navigateToExerciseList(
  BuildContext context, {
  required String workoutName,
  required String duration,
  required String backgroundImageUrl,
}) {
  final exercises = [
    {
      'name': 'Jumping Jacks',
      'count': '00:30',
      'animationUrl': 'https://example.com/jumping-jacks.gif',
    },
    {
      'name': 'Push-ups',
      'count': 'x10',
      'animationUrl': 'https://example.com/pushups.gif',
    },
    {
      'name': 'Mountain Climbers',
      'count': '00:45',
      'animationUrl': 'https://example.com/mountain-climbers.gif',
    },
    {
      'name': 'Squats',
      'count': 'x15',
      'animationUrl': 'https://example.com/squats.gif',
    },
  ];

  context.push(
    '/exercise-list',
    extra: {
      'workoutName': workoutName,
      'duration': duration,
      'exerciseCount': exercises.length,
      'backgroundImageUrl': backgroundImageUrl,
      'exercises': exercises,
    },
  );
}
