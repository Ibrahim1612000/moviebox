import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Brand Colors
  static const Color cinemaRed = Color(0xFFE50914);
  static const Color gold = Color(0xFFFFD369);
  
  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF111318);
  static const Color darkSurfaceLowest = Color(0xFF0C0E13);
  static const Color darkSurfaceLow = Color(0xFF1A1B21);
  static const Color darkSurfaceHigh = Color(0xFF282A2F);
  static const Color darkSurfaceHighest = Color(0xFF33353A);
  static const Color darkOnSurface = Color(0xFFE2E2E9);
  static const Color darkOutlineVariant = Color(0xFF5E3F3B);

  // Light Theme Colors (Derived for the Light Mode requirement)
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurfaceLowest = Color(0xFFF3F4F6);
  static const Color lightSurfaceLow = Color(0xFFE5E7EB);
  static const Color lightSurfaceHigh = Color(0xFFD1D5DB);
  static const Color lightSurfaceHighest = Color(0xFF9CA3AF);
  static const Color lightOnSurface = Color(0xFF111827);
  static const Color lightOutlineVariant = Color(0xFF9CA3AF);

  // Radii
  static const double radiusMd = 12.0;
  static const double radiusXl = 24.0;

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: cinemaRed,
      colorScheme: const ColorScheme.dark(
        primary: cinemaRed,
        secondary: gold,
        surface: darkBackground,
        surfaceContainerHighest: darkSurfaceHighest,
        onSurface: darkOnSurface,
        outlineVariant: darkOutlineVariant,
      ),
      textTheme: _buildTextTheme(Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBackground,
      primaryColor: cinemaRed,
      colorScheme: const ColorScheme.light(
        primary: cinemaRed,
        secondary: gold,
        surface: lightBackground,
        surfaceContainerHighest: lightSurfaceHighest, // Need lighter variant for light theme chips if used
        onSurface: lightOnSurface,
        outlineVariant: lightOutlineVariant,
      ),
      textTheme: _buildTextTheme(lightOnSurface),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: lightOnSurface),
      ),
      useMaterial3: true,
    );
  }

  static TextTheme _buildTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: GoogleFonts.plusJakartaSans(
        fontSize: 56, // 3.5rem equivalent
        fontWeight: FontWeight.bold,
        color: textColor,
        letterSpacing: -1.12, // -2% of 56
      ),
      headlineMedium: GoogleFonts.plusJakartaSans(
        fontSize: 28, // 1.75rem equivalent
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: GoogleFonts.manrope(
        fontSize: 18, // 1.125rem equivalent
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 16, // 1rem equivalent
        fontWeight: FontWeight.normal,
        height: 1.6,
        color: textColor,
      ),
      labelSmall: GoogleFonts.manrope(
        fontSize: 11, // 0.6875rem equivalent
        fontWeight: FontWeight.bold,
        letterSpacing: 0.55, // +5% tracking
        color: textColor,
      ),
    );
  }
}
