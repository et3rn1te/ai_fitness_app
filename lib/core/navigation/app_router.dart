import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/01_authentication/presentation/screen/login_screen.dart';
import '../../features/01_authentication/presentation/screen/register_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/homne',
    routes: [
      GoRoute(path: '/', redirect: (context, state) => '/login'),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      // Placeholder for our home screen
      GoRoute(
        path: '/home',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Home Screen'))),
      ),
    ],
  );
}
