import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF1E1E2C);
  static const Color secondaryColor = Color(0xFF2D2D44);
  static const Color accentColor = Color(0xFF00F5FF);
  static const Color neonBlue = Color(0xFF00F5FF);
  static const Color neonPurple = Color(0xFFB026FF);
  static const Color neonPink = Color(0xFFFF10F0);
  static const Color neonGreen = Color(0xFF00FF9D);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1E1E2C),
      Color(0xFF2D2D44),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00F5FF),
      Color(0xFFB026FF),
    ],
  );

  // Glass effect decoration
  static BoxDecoration glassDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Colors.white24, Colors.white10],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 2,
      ),
      BoxShadow(
        color: neonBlue.withOpacity(0.1),
        blurRadius: 20,
        spreadRadius: 5,
      ),
    ],
  );

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.white70,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: Colors.white70,
  );

  // Button Styles
  static final elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
  ).copyWith(
    elevation: MaterialStateProperty.all(0),
    shadowColor: MaterialStateProperty.all(neonBlue.withOpacity(0.3)),
  );

  // Input Decoration
  static InputDecoration textFieldDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.poppins(
        color: Colors.white70,
        fontSize: 14,
      ),
      prefixIcon: Icon(icon, color: Colors.white70),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.white30),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: neonBlue),
      ),
    );
  }

  // Navigation Rail Style
  static final navigationRailTheme = NavigationRailThemeData(
    backgroundColor: Colors.transparent,
    selectedIconTheme: IconThemeData(
      color: neonBlue,
      size: 28,
      shadows: [
        Shadow(
          color: neonBlue.withOpacity(0.5),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    unselectedIconTheme: IconThemeData(
      color: Colors.white.withOpacity(0.5),
      size: 24,
    ),
    selectedLabelTextStyle: GoogleFonts.poppins(
      color: neonBlue,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(
          color: neonBlue.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    unselectedLabelTextStyle: GoogleFonts.poppins(
      color: Colors.white.withOpacity(0.5),
      fontSize: 14,
    ),
  );

  // Shadows
  static List<BoxShadow> neonShadow(Color color) => [
    BoxShadow(
      color: color.withOpacity(0.3),
      blurRadius: 8,
      spreadRadius: 2,
    ),
    BoxShadow(
      color: color.withOpacity(0.2),
      blurRadius: 16,
      spreadRadius: 4,
    ),
  ];
} 