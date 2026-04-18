// lib/widgets/skill_bar.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

class SkillBar extends StatefulWidget {
  final Skill skill;
  final int delay;

  const SkillBar({super.key, required this.skill, this.delay = 0});

  @override
  State<SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return VisibilityDetector(
      key: Key('skill_${widget.skill.name}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) _trigger();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.skill.name,
                style: theme.textTheme.titleLarge?.copyWith(fontSize: 15),
              ),
              AnimatedBuilder(
                animation: _anim,
                builder: (_, __) => Text(
                  '${(_anim.value * widget.skill.level * 100).round()}%',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              borderRadius: BorderRadius.circular(3),
            ),
            child: AnimatedBuilder(
              animation: _anim,
              builder: (_, __) => FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _anim.value * widget.skill.level,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.primaryGradient,
                    ),
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
