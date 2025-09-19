import 'package:flutter/material.dart';
import '../../widgets/common/flowstate_app_bar.dart';
import '../../widgets/common/flowstate_bottom_nav_bar.dart';

class PoseScreen extends StatelessWidget {
  const PoseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FlowstateAppBar(title: 'Pose'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Pose Detection',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Pose detection functionality will be implemented here.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: FlowstateBottomNavBar(
        currentIndex: 2, // Pose tab
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/training');
              break;
            case 2:
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
