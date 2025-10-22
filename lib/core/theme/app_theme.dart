import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define a primary color. You can change this one color
  // and it will update the whole app.
  static const Color _primaryColor = Colors.blue;

  static final ThemeData lightTheme = ThemeData.light().copyWith(
    // 1. Set the main colors
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: Colors.white,

    // 2. Set the default font
    // This applies "Inter" to all text in the app.
    textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),

    // 3. Style the ElevatedButton (PrimaryButton)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: _primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
    ),

    // 4. Style the TextFormField (AuthTextField)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
    ),

    // 5. Style the TextButton
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );

  // You could also define a darkTheme here later
  // static final ThemeData darkTheme = ThemeData.dark()...
}
