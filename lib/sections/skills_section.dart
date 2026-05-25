// lib/sections/skills_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import '../widgets/skill_bar.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _visible = false;
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('skills_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        color: isDark ? AppColors.darkSurface : AppColors.lightCard,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              label: 'Skills',
              title: 'My Technical\nArsenal',
              subtitle: 'Refined through years of building scalable, production-grade applications.',
            ),
            const SizedBox(height: 48),
            // Category tabs
            if (_visible)
              FadeInUp(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: PortfolioData.skillCategories
                        .asMap()
                        .entries
                        .map((e) => _CategoryTab(
                              label: e.value.title,
                              selected: _selectedCategoryIndex == e.key,
                              onTap: () => setState(() => _selectedCategoryIndex = e.key),
                            ))
                        .toList(),
                  ),
                ),
              ),
            const SizedBox(height: 40),
            // Skills grid
            if (_visible)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _SkillGrid(
                  key: ValueKey(_selectedCategoryIndex),
                  category: PortfolioData.skillCategories[_selectedCategoryIndex],
                ),
              ),
            const SizedBox(height: 60),
            // Tech tags cloud
            if (_visible)
              FadeInUp(
                delay: const Duration(milliseconds: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Technologies I\'ve Worked With',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: PortfolioData.techTags.asMap().entries.map((e) {
                        final colors = [
                          AppColors.accent,
                          AppColors.accentAlt,
                          AppColors.accentPink,
                          AppColors.accentGreen,
                          AppColors.accentOrange,
                        ];
                        final color = colors[e.key % colors.length];
                        return _TechTag(label: e.value, color: color);
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryTab({required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          gradient: selected
              ? const LinearGradient(colors: AppColors.primaryGradient)
              : null,
          color: selected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: selected ? Colors.transparent : AppColors.darkBorder,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.grey,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class _SkillGrid extends StatelessWidget {
  final SkillCategory category;

  const _SkillGrid({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return isMobile
        ? Column(
            children: category.skills
                .asMap()
                .entries
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SkillBar(skill: e.value, delay: e.key * 100),
                    ))
                .toList(),
          )
        : GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 6,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 40,
            mainAxisSpacing: 20,
            children: category.skills
                .asMap()
                .entries
                .map((e) => SkillBar(skill: e.value, delay: e.key * 100))
                .toList(),
          );
  }
}

class _TechTag extends StatefulWidget {
  final String label;
  final Color color;
  const _TechTag({required this.label, required this.color});

  @override
  State<_TechTag> createState() => _TechTagState();
}

class _TechTagState extends State<_TechTag> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _hovered
              ? widget.color.withValues(alpha: 0.15)
              : (isDark ? AppColors.darkCard : AppColors.lightSurface),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: _hovered ? widget.color : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: widget.color.withValues(alpha: 0.2),
                    blurRadius: 12,
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            color: _hovered ? widget.color : null,
            fontWeight: _hovered ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
