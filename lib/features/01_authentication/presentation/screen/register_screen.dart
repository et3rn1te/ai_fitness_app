import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_viewmodel.dart';
import '../widget/auth_text_field.dart';
import '../widget/google_sign_in_button.dart';
import '../widget/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // This helper method will be called *after* the async call completes
  void _handleAuthState() {
    // Check if the widget is still in the tree
    if (!mounted) return;

    // Get the viewmodel *without* listening
    final viewModel = context.read<AuthViewModel>();

    if (viewModel.state == AuthState.success) {
      // Navigate to home on success
      context.go('/home');
    }
    if (viewModel.state == AuthState.error && viewModel.errorMessage != null) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // --- Async onPressed Handlers ---

  Future<void> _register() async {
    await context.read<AuthViewModel>().register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    _handleAuthState();
  }

  Future<void> _googleLogin() async {
    await context.read<AuthViewModel>().handleGoogleSignIn();
    _handleAuthState();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthViewModel>().state;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Start your fitness journey today',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              AuthTextField(
                hintText: 'Full Name',
                controller: _nameController,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                hintText: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                hintText: 'Password',
                controller: _passwordController,
                obscureText: true,
              ),
              const SizedBox(height: 24),
              if (authState == AuthState.loading)
                const Center(child: CircularProgressIndicator())
              else ...[
                PrimaryButton(
                  text: 'Register',
                  onPressed: _register, // Call async helper
                ),
                const SizedBox(height: 16),
                GoogleSignInButton(
                  onPressed: _googleLogin, // Call async helper
                ),
              ],
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    child: const Text('Log in'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
