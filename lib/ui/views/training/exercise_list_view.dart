// import 'package:ai_fitness_app/core/viewmodels/exercise_view_model.dart';
// import 'package:ai_fitness_app/ui/widgets/exercises/exercise_item.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';

// class ExerciseListView extends StatelessWidget {
//   const ExerciseListView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final viewModel = context.watch<ExerciseViewModel>();

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image
//           Container(
//             height: 200,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(viewModel.workoutImage),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.3),
//                     Colors.black.withOpacity(0.7),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Content
//           CustomScrollView(
//             slivers: [
//               // App Bar
//               SliverAppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 pinned: true,
//                 expandedHeight: 200,
//                 leading: IconButton(
//                   icon: const Icon(Icons.arrow_back, color: Colors.white),
//                   onPressed: () => context.pop(),
//                 ),
//                 actions: [
//                   IconButton(
//                     icon: const Icon(Icons.more_vert, color: Colors.white),
//                     onPressed: () {
//                       // Show options menu
//                     },
//                   ),
//                 ],
//               ),

//               // Main Content
//               SliverToBoxAdapter(
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.vertical(
//                       top: Radius.circular(20),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Workout Info
//                       Padding(
//                         padding: const EdgeInsets.all(20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               viewModel.workoutTitle,
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 12),
//                             Row(
//                               children: [
//                                 _buildInfoBadge(
//                                   Icons.timer,
//                                   '${viewModel.workoutDuration} min',
//                                   Colors.blue,
//                                 ),
//                                 const SizedBox(width: 12),
//                                 _buildInfoBadge(
//                                   Icons.fitness_center,
//                                   '${viewModel.exercises.length} exercises',
//                                   Colors.purple,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),

//                       // Exercises List
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             const Text(
//                               'Exercises',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             TextButton(
//                               onPressed: () {
//                                 // Handle edit
//                               },
//                               child: const Row(
//                                 children: [
//                                   Text('Edit'),
//                                   Icon(Icons.chevron_right),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ListView.separated(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         padding: const EdgeInsets.all(20),
//                         itemCount: viewModel.exercises.length,
//                         separatorBuilder: (context, index) => const Divider(),
//                         itemBuilder: (context, index) {
//                           final exercise = viewModel.exercises[index];
//                           return ExerciseItem(
//                             name: exercise.name,
//                             count: exercise.count,
//                             animationUrl: exercise.animationUrl,
//                             onReplace: () {
//                               // Handle replace
//                             },
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 100), // Space for button
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           // Start Button
//           Positioned(
//             left: 20,
//             right: 20,
//             bottom: 20,
//             child: ElevatedButton(
//               onPressed: () {
//                 // Start workout
//               },
//               style: ElevatedButton.styleFrom(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               child: const Text(
//                 'Start Workout',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildInfoBadge(IconData icon, String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, size: 16, color: color),
//           const SizedBox(width: 4),
//           Text(
//             text,
//             style: TextStyle(color: color, fontWeight: FontWeight.w500),
//           ),
//         ],
//       ),
//     );
//   }
// }
