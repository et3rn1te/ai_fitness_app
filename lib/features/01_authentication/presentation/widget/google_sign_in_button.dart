import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed; // <-- ADDED THIS

  const GoogleSignInButton({
    super.key,
    required this.onPressed, // <-- ADDED THIS
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed, // <-- UPDATED THIS
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: BorderSide(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // TODO: Add google_logo.png to your assets/images/ folder
          // For now, we'll use an icon as a placeholder
          Icon(Icons.g_mobiledata, color: Colors.blue[800], size: 30),
          // Image.asset('assets/images/google_logo.png', height: 24),
          const SizedBox(width: 12),
          const Text(
            'Sign in with Google',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
