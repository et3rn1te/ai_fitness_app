import 'package:flutter/material.dart';

class FlowstateBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const FlowstateBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Training'),
        BottomNavigationBarItem(icon: Icon(Icons.man), label: 'Pose'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      onTap: (index) {
        onTap(index);
      },
    );
  }
}
