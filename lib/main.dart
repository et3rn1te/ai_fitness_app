import 'package:ai_fitness_app/core/navigation/app_router.dart';
import 'package:ai_fitness_app/features/02_workout_discovery/presentation/viewmodel/workout_discovery_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutDiscoveryViewModel()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 22, 73, 1),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
