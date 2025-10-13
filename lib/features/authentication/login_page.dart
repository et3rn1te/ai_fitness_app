import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyLoginPage extends StatelessWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the home page using GoRouter
            context.go('/home');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
