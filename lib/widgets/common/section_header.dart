import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onActionPressed;
  final String? actionLabel;

  const SectionHeader({
    super.key,
    required this.title,
    this.onActionPressed,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              letterSpacing: -0.5,
            ),
          ),
          if (onActionPressed != null && actionLabel != null)
            TextButton(onPressed: onActionPressed, child: Text(actionLabel!)),
        ],
      ),
    );
  }
}
