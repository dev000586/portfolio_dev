// lib/widgets/tech_chip.dart
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TechChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  final Color? color;

  const TechChip({
    super.key,
    required this.label,
    this.selected = false,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final chipColor = color ?? AppColors.accent;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected
              ? chipColor.withOpacity(0.2)
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? chipColor : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: selected ? chipColor : null,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
