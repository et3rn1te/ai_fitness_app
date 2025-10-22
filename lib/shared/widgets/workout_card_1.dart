// import 'package:ai_fitness_app/data/models/workouts/workout_card_model.dart';
// import 'package:flutter/material.dart';

// class WorkoutCardVariant1 extends StatelessWidget {
//   final WorkoutCard workout;
//   final VoidCallback? onTap;

//   const WorkoutCardVariant1({super.key, required this.workout, this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(16),
//         child: Container(
//           height: 160,
//           width: 375,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(16),
//             image: DecorationImage(
//               image: NetworkImage(workout.imageUrl),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
//               ),
//             ),
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text(
//                   workout.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
