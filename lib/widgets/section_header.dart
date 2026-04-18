// lib/widgets/section_header.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import '../theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInLeft(
          duration: const Duration(milliseconds: 600),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: AppColors.primaryGradient),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              label.toUpperCase(),
              style: theme.textTheme.labelLarge?.copyWith(
                color: Colors.white,
                letterSpacing: 2,
                fontSize: 11,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInUp(
          delay: const Duration(milliseconds: 200),
          child: Text(title, style: theme.textTheme.displaySmall),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: Text(
              subtitle!,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}
