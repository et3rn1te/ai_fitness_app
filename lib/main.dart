import 'package:ai_fitness_app/core/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Core imports
import 'core/navigation/app_router.dart';
import 'core/theme/app_theme.dart';

// Feature imports
import 'features/01_authentication/data/api/auth_api.dart';
import 'features/01_authentication/data/repository/auth_repository_impl.dart';
import 'features/01_authentication/domain/repository/auth_repository.dart';
import 'features/01_authentication/presentation/viewmodel/auth_viewmodel.dart';

void main() {
  // Run the app, wrapped in our Dependency Injection widget
  runApp(const AppProviders())
}

class AppProviders extends StatelessWidget {
  const AppProviders({super.key});

  @override
  Widget build(BuildContext context) {
    // This is where we set up all our app-wide dependencies
    return MultiProvider(
      providers: [
        // --- Core Dependencies ---
        // 1. ApiClient (our Dio instance)
        Provider<ApiClient>(create: (_) => ApiClient()),

        // --- Authentication Feature Dependencies ---
        // 2. AuthApi (depends on ApiClient)
        ProxyProvider<ApiClient, AuthApi>(
          update: (_, apiClient, __) => AuthApi(apiClient),
        ),
        // 3. AuthRepository (depends on AuthApi)
        ProxyProvider<AuthApi, AuthRepository>(
          update: (_, authApi, __) => AuthRepositoryImpl(authApi),
        ),
        // 4. AuthViewModel (depends on AuthRepository)
        ChangeNotifierProxyProvider<AuthRepository, AuthViewModel>(
          create: (context) => AuthViewModel(context.read<AuthRepository>()),
          update: (_, authRepo, __) => AuthViewModel(authRepo),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AI Fitness',
      debugShowCheckedModeBanner: false,

      // By setting this, the entire app will use your styles.
      theme: AppTheme.lightTheme,

      // This connects our GoRouter configuration
      routerConfig: AppRouter.router,
    );
  }
}
