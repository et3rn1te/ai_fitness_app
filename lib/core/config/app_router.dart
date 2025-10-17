import 'package:ai_fitness_app/data/models/workouts/workout_detail_model.dart';
import 'package:ai_fitness_app/features/01_authentication/login_screen.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/screens/workout_detail_screen.dart';
import 'package:ai_fitness_app/features/03_workout_editor/presentation/screens/custom_workout_screen.dart';
import 'package:ai_fitness_app/features/04_workout_player/presentation/screens/workout_player_screen.dart';
import 'package:ai_fitness_app/presentation/home_screen.dart';
import 'package:ai_fitness_app/features/05_pose_detection/presentation/screens/pose_detection_screen.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/screens/workout_category_screen.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/screens/workout_results_screen.dart';
import 'package:ai_fitness_app/features/07_settings/presentation/screens/settings_screen.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/screens/workout_discovery_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      name: 'login',
      path: '/login',
      builder: (context, state) => const LoginScreen(title: 'Login Page'),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: 'training',
      path: '/training',
      builder: (context, state) => const WorkoutDiscoveryScreen(),
    ),
    GoRoute(
      name: 'category',
      path: '/category',
      builder: (context, state) => const WorkoutCategoryScreen(),
    ),
    GoRoute(
      name: 'results',
      path: '/results',
      builder: (context, state) {
        final allParams = state.uri.queryParameters;
        final title = allParams['title'] ?? 'Results';
        final queryParams = Map<String, String>.from(allParams)
          ..remove('title');
        return WorkoutResultsScreen(title: title, queryParams: queryParams);
      },
    ),
    GoRoute(
      name: 'custom_workout',
      path: '/custom_workout',
      builder: (context, state) => const CustomWorkoutScreen(),
    ),
    GoRoute(
      name: 'workout_player',
      path: '/workout_player',
      builder: (context, state) {
        final workout = state.extra as WorkoutDetail;
        return WorkoutPlayerScreen(workout: workout);
      },
    ),
    GoRoute(
      name: 'workout_detail',
      path: '/workout/:workoutId',
      builder: (context, state) {
        final workoutId =
            int.tryParse(state.pathParameters['workoutId'] ?? '') ?? 0;
        if (workoutId > 0) {
          return WorkoutDetailScreen(workoutId: workoutId);
        }
        return const Scaffold(body: Center(child: Text("Invalid Workout ID")));
      },
    ),
    GoRoute(
      name: 'pose_detection',
      path: '/pose_detection',
      builder: (context, state) => const PoseDetectionScreen(),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
