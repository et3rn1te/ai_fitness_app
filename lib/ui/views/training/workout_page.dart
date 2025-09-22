// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:ai_fitness_app/ui/widgets/workout/workout_card_1.dart';
// import 'package:ai_fitness_app/ui/widgets/workout/workout_card_2.dart';

// class MyWorkoutPage extends StatelessWidget {
//   const MyWorkoutPage({super.key, required this.title});

//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(title),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             WorkoutCardVariant1(
//               title: 'Morning Yoga',
//               duration: '30 min',
//               level: 'Beginner',
//               backgroundImageUrl: 'https://example.com/yoga.jpg',
//               onTap: () {
//                 context.push('/home');
//               },
//             ),
//             WorkoutCardVariant2(
//               title: 'HIIT Workout',
//               duration: '45 min',
//               energyLevel: 3,
//               imageUrl: 'https://example.com/hiit.jpg',
//               onTap: () {
//                 context.push('/home');
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
