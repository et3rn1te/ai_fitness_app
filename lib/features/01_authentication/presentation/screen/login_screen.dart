import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../viewmodel/auth_viewmodel.dart';
import '../widget/auth_text_field.dart';
import '../widget/google_sign_in_button.dart';
import '../widget/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAuthState() {
    if (!mounted) return;

    final viewModel = context.read<AuthViewModel>();

    if (viewModel.state == AuthState.success) {
      context.go('/home');
    }
    if (viewModel.state == AuthState.error && viewModel.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(viewModel.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _login() async {
    await context.read<AuthViewModel>().login(
      _emailController.text.trim(),
      _passwordController.text.trim(),
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
                'Welcome Back',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Login to continue your fitness journey',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
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
              // Show loading indicator or buttons
              if (authState == AuthState.loading)
                const Center(child: CircularProgressIndicator())
              else ...[
                PrimaryButton(
                  text: 'Login',
                  onPressed: _login, // Call the async helper
                ),
                const SizedBox(height: 16),
                GoogleSignInButton(
                  onPressed: _googleLogin, // Call the async helper
                ),
              ],
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      context.go('/register');
                    },
                    child: const Text('Sign up'),
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
