// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/portfolio_data.dart';

class AppColors {
  // Dark theme
  static const Color darkBg = Color(0xFF0A0A0F);
  static const Color darkSurface = Color(0xFF13131A);
  static const Color darkCard = Color(0xFF1A1A24);
  static const Color darkBorder = Color(0xFF2A2A3A);

  // Light theme
  static const Color lightBg = Color(0xFFF5F5FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF0F0F8);
  static const Color lightBorder = Color(0xFFDDDDEE);

  // Accent colors
  static const Color accent = Color(0xFF6C63FF);
  static const Color accentAlt = Color(0xFF00E5FF);
  static const Color accentGreen = Color(0xFF00E676);
  static const Color accentPink = Color(0xFFFF6B9D);
  static const Color accentOrange = Color(0xFFFF9800);

  // Gradient
  static const List<Color> primaryGradient = [Color(0xFF6C63FF), Color(0xFF00E5FF)];
  static const List<Color> heroGradient = [Color(0xFF6C63FF), Color(0xFFFF6B9D)];
  static const List<Color> cardGradient = [Color(0xFF1A1A2E), Color(0xFF16213E)];

  static List<Color> getProjectGradient(List<ProjectCategory> categories) {
    final Map<ProjectCategory, List<Color>> colors = {
      ProjectCategory.mobile: [
        const Color(0xFF6C63FF),
        const Color(0xFF00E5FF),
      ],
      ProjectCategory.web: [
        const Color(0xFF00E676),
        const Color(0xFF00BCD4),
      ],
      ProjectCategory.desktop: [
        const Color(0xFFFF9800),
        const Color(0xFFFF6B9D),
      ],
      ProjectCategory.openSource: [
        const Color(0xFFFF6B9D),
        const Color(0xFF9C27B0),
      ],
    };

    if (categories.isEmpty) return AppColors.primaryGradient;

    final List<Color> merged = [];
    for (final category in categories) {
      final gradient = colors[category];
      if (gradient != null) {
        merged.addAll(gradient);
      }
    }

    return merged.length > 3 ? merged.sublist(0, 3) : merged;
  }
}

class AppTheme {
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBg,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.accent,
        secondary: AppColors.accentAlt,
        surface: AppColors.darkSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
      ),
      textTheme: _buildTextTheme(Colors.white),
      cardTheme: CardThemeData(
        color: AppColors.darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.darkBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.accentPink, width: 2),
        ),
        labelStyle: const TextStyle(color: Color(0xFFAAAAAA)),
        hintStyle: const TextStyle(color: Color(0xFF666688)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.lightBg,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        secondary: AppColors.accentAlt,
        surface: AppColors.lightSurface,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Color(0xFF1A1A2E),
      ),
      textTheme: _buildTextTheme(const Color(0xFF1A1A2E)),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.lightBorder, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightCard,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.accentPink, width: 2),
        ),
        labelStyle: TextStyle(color: Colors.grey[600]),
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme(Color baseColor) {
    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72, fontWeight: FontWeight.w800, color: baseColor, height: 1.0,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 52, fontWeight: FontWeight.w700, color: baseColor, height: 1.1,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 36, fontWeight: FontWeight.w700, color: baseColor, height: 1.2,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 28, fontWeight: FontWeight.w600, color: baseColor,
      ),
      headlineSmall: GoogleFonts.spaceGrotesk(
        fontSize: 22, fontWeight: FontWeight.w600, color: baseColor,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 18, fontWeight: FontWeight.w600, color: baseColor,
      ),
      bodyLarge: GoogleFonts.dmSans(
        fontSize: 16, fontWeight: FontWeight.w400, color: baseColor.withOpacity(0.85),
      ),
      bodyMedium: GoogleFonts.dmSans(
        fontSize: 14, fontWeight: FontWeight.w400, color: baseColor.withOpacity(0.75),
      ),
      labelLarge: GoogleFonts.dmMono(
        fontSize: 13, fontWeight: FontWeight.w500, color: baseColor.withOpacity(0.8),
        letterSpacing: 0.5,
      ),
    );
  }
}
