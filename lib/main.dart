import 'package:ai_fitness_app/ui/views/auth/login_page.dart';
import 'package:ai_fitness_app/ui/views/home_page.dart';
import 'package:ai_fitness_app/ui/views/pose/pose_detection_page.dart';
import 'package:ai_fitness_app/ui/views/search/category_page.dart';
import 'package:ai_fitness_app/ui/views/search/results_page.dart';
import 'package:ai_fitness_app/ui/views/settings/settings_page.dart';
import 'package:ai_fitness_app/ui/views/training/training_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 22, 73, 1),
        ),
      ),
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  routes: <RouteBase>[
    GoRoute(
      name: '/login',
      path: '/login',
      builder: (context, state) {
        return const MyLoginPage(title: 'Login Page');
      },
    ),
    GoRoute(
      name: '/home',
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: '/training',
      path: '/training',
      builder: (context, state) {
        return const TrainingPage();
      },
    ),
    GoRoute(
      name: '/category',
      path: '/category',
      builder: (context, state) {
        return const CategoryPage();
      },
    ),
    GoRoute(
      name: '/results',
      path: '/results',
      builder: (context, state) {
        final Map<String, dynamic>? extras =
            state.extra as Map<String, dynamic>?;
        return ResultsPage(
          categoryName: extras?['categoryName'] ?? 'Unknown',
          workouts: extras?['workouts'] as List<Map<String, dynamic>>,
        );
      },
    ),
    GoRoute(
      name: '/pose_detection',
      path: '/pose_detection',
      builder: (context, state) {
        return const PoseDetectionPage();
      },
    ),
    GoRoute(
      name: '/settings',
      path: '/settings',
      builder: (context, state) {
        return const SettingsPage();
      },
    ),
  ],
);
