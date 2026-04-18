// lib/sections/achievements_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class AchievementsSection extends StatefulWidget {
  const AchievementsSection({super.key});

  @override
  State<AchievementsSection> createState() => _AchievementsSectionState();
}

class _AchievementsSectionState extends State<AchievementsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return VisibilityDetector(
      key: const Key('achievements_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Achievements',
              title: 'Recognition &\nCertifications',
              subtitle:
                  'Milestones that mark my journey in the Flutter ecosystem.',
            ),
            const SizedBox(height: 48),
            if (_visible)
              MasonryGridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile
                      ? 1
                      : width < 950
                          ? 2
                          : 3,
                ),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: PortfolioData.achievements.length,
                itemBuilder: (ctx, i) => FadeInUp(
                  delay: Duration(milliseconds: i * 100),
                  child: _AchievementCard(
                      achievement: PortfolioData.achievements[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _AchievementCard extends StatefulWidget {
  final Achievement achievement;

  const _AchievementCard({required this.achievement});

  @override
  State<_AchievementCard> createState() => _AchievementCardState();
}

class _AchievementCardState extends State<_AchievementCard> {
  bool _hovered = false;

  IconData _icon() {
    switch (widget.achievement.icon) {
      case 'award':
        return Icons.workspace_premium;
      case 'trophy':
        return Icons.emoji_events;
      case 'mic':
        return Icons.mic;
      case 'code':
        return Icons.code;
      case 'certificate':
        return Icons.verified;
      case 'people':
        return Icons.people;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = Color(widget.achievement.color);

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()..translate(0.0, _hovered ? -4.0 : 0.0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? color.withOpacity(0.5)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: 1.5,
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                      color: color.withOpacity(0.15),
                      blurRadius: 24,
                      spreadRadius: 2)
                ]
              : [],
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(_icon(), color: color, size: 24),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      widget.achievement.year,
                      style: TextStyle(
                        fontSize: 11,
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 20,),
              Text(
                widget.achievement.title,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 16),
              ),
              const SizedBox(height: 6),
              Text(
                widget.achievement.subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
