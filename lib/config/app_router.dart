import 'package:ai_fitness_app/ui/views/auth/login_page.dart';
import 'package:ai_fitness_app/ui/views/home_page.dart';
import 'package:ai_fitness_app/ui/views/pose/pose_detection_page.dart';
import 'package:ai_fitness_app/ui/views/workouts/custom_workout_page.dart';
import 'package:ai_fitness_app/ui/views/workouts/workout_category_page.dart';
import 'package:ai_fitness_app/ui/views/workouts/workout_results_page.dart';
import 'package:ai_fitness_app/ui/views/settings/settings_page.dart';
import 'package:ai_fitness_app/ui/views/workouts/training_page.dart';
import 'package:ai_fitness_app/ui/views/workouts/workout_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const MyLoginPage(title: 'Login Page'),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: 'training',
      path: '/training',
      builder: (context, state) => const TrainingPage(),
    ),
    GoRoute(
      name: 'category',
      path: '/category',
      builder: (context, state) => const WorkoutCategoryPage(),
    ),
    GoRoute(
      name: 'results',
      path: '/results',
      builder: (context, state) {
        final allParams = state.uri.queryParameters;
        final title = allParams['title'] ?? 'Results';
        final queryParams = Map<String, String>.from(allParams)
          ..remove('title');
        return WorkoutResultsPage(title: title, queryParams: queryParams);
      },
    ),
    GoRoute(
      name: 'custom_workout',
      path: '/custom_workout',
      builder: (context, state) => const CustomWorkoutPage(),
    ),
    GoRoute(
      name: 'workoutDetail',
      path: '/workout/:workoutId',
      builder: (context, state) {
        final workoutId =
            int.tryParse(state.pathParameters['workoutId'] ?? '') ?? 0;
        if (workoutId > 0) {
          return WorkoutDetailPage(workoutId: workoutId);
        }
        return const Scaffold(body: Center(child: Text("Invalid Workout ID")));
      },
    ),
    GoRoute(
      name: 'pose_detection',
      path: '/pose_detection',
      builder: (context, state) => const PoseDetectionPage(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);
