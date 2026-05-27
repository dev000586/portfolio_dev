
import 'package:flutter/material.dart';
import 'package:palette_generator_master/palette_generator_master.dart';

class Utils {
  static String getExperience(DateTime startDate) {
    final now = DateTime.now();

    int years = now.year - startDate.year;
    int months = now.month - startDate.month;

    // Adjust if current month is before start month
    if (months < 0) {
      years--;
      months += 12;
    }

    // Convert months to .5 if >= 6
    final half = months >= 6 ? 0.5 : 0.0;

    final total = years + half;

    // Remove .0 if whole number
    if (half == 0) {
      return '$years+';
    } else {
      return '$total+';
    }
  }

  static Future<List<Color>> generatePalette(String imagePath) async {
    await Future.delayed(const Duration(milliseconds: 100));
    final ImageProvider imageProvider = AssetImage(imagePath);

    final PaletteGeneratorMaster paletteGenerator =
    await PaletteGeneratorMaster.fromImageProvider(
      imageProvider,
      maximumColorCount: 16,
      generateHarmony: true,      // Generate color harmony
    );

    // Access extracted colors
    final Color? dominantColor = paletteGenerator.dominantColor?.color;
    final Color? vibrantColor = paletteGenerator.vibrantColor?.color;
    final Color? mutedColor = paletteGenerator.mutedColor?.color;

    List<Color> colors = [dominantColor ?? const Color(0xFF6C63FF), vibrantColor ?? const Color(0xFF00E5FF), mutedColor ?? const Color(0xFFFFFFFF)];
    return colors;
  }
}