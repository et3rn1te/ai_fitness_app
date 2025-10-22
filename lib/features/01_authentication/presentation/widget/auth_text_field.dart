import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // <-- ADDED THIS
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;

  const AuthTextField({
    super.key,
    required this.hintText,
    required this.controller, // <-- ADDED THIS
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // <-- ADDED THIS
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
