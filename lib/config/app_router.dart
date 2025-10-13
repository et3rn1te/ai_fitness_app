import 'package:ai_fitness_app/features/authentication/login_page.dart';
import 'package:ai_fitness_app/features/home_page.dart';
import 'package:ai_fitness_app/features/pose/presentation/pose_detection_page.dart';
import 'package:ai_fitness_app/features/workouts/presentation/custom_workout_page.dart';
import 'package:ai_fitness_app/features/workouts/presentation/category_page.dart';
import 'package:ai_fitness_app/features/workouts/presentation/results_page.dart';
import 'package:ai_fitness_app/features/settings/presentation/settings_page.dart';
import 'package:ai_fitness_app/features/workouts/presentation/training_page.dart';
import 'package:ai_fitness_app/features/workouts/presentation/detail_page.dart';
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
      builder: (context, state) => const CategoryPage(),
    ),
    GoRoute(
      name: 'results',
      path: '/results',
      builder: (context, state) {
        final allParams = state.uri.queryParameters;
        final title = allParams['title'] ?? 'Results';
        return ResultsPage(title: title);
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
