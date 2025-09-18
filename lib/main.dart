import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/workout_player_screen.dart';
import 'screens/discover_screen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FlowstateApp());
}

class FlowstateApp extends StatefulWidget {
  const FlowstateApp({super.key});

  @override
  State<FlowstateApp> createState() => _FlowstateAppState();
}

class _FlowstateAppState extends State<FlowstateApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flowstate',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      themeMode: _themeMode,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthScreen(),
        '/home': (context) => const HomeScreen(),
        '/discover': (context) => const DiscoverScreen(),
        '/profile': (context) => ProfileScreen(
          onThemeChanged: toggleTheme,
          currentTheme: _themeMode,
        ),
        '/workout-player': (context) => const WorkoutPlayerScreen(),
      },
    );
  }
}
