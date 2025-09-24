import 'package:flutter/material.dart';

class WorkoutTypeItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final Color? iconColor;

  const WorkoutTypeItem({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 80,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!, width: 1),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Centers row contents
            crossAxisAlignment:
                CrossAxisAlignment.center, // Vertically centers items
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 1.2, // Adjust line height for better readability
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.left, // Keep text left-aligned
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Icon(icon, size: 36, color: iconColor ?? Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
