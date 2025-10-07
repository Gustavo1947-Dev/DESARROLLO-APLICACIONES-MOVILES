
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define Colors from the Design System
  static const Color primary = Color(0xFF657D3E);
  static const Color accent = Color(0xFFD4E9B5);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textInactive = Color(0xFFA0A0A0);

  // Corner Radius
  static const double cornerRadius = 12.0;

  // Elevation
  static const double cardElevation = 2.0;

  // Main Theme Data
  static ThemeData getTheme() {
    final textTheme = GoogleFonts.poppinsTextTheme(
      const TextTheme(
        bodyLarge: TextStyle(fontWeight: FontWeight.w400), // Body/Regular
        bodyMedium: TextStyle(fontWeight: FontWeight.w400),
        headlineMedium: TextStyle(fontWeight: FontWeight.w500), // Headers/Medium
        displaySmall: TextStyle(fontWeight: FontWeight.w600), // Titles/Semibold
        titleLarge: TextStyle(fontWeight: FontWeight.w600, color: primary),
      ),
    );

    return ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: primary,
        onPrimary: Colors.white,
        secondary: accent,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.white,
        background: background,
        onBackground: Colors.black,
        surface: surface,
        onSurface: Colors.black,
      ),
      textTheme: textTheme,
      cardTheme: const CardThemeData(
        elevation: cardElevation,
        color: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        focusColor: primary,
        hintStyle: const TextStyle(color: textInactive),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: textInactive, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: textInactive, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
          borderSide: const BorderSide(color: primary, width: 2.0),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          textStyle: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: textTheme.titleLarge?.copyWith(color: Colors.white),
      ),
      iconTheme: const IconThemeData(
        color: primary,
      ),
    );
  }
}
