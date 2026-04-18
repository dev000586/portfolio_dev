// lib/sections/experience_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/utils/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import '../widgets/tech_chip.dart';

class ExperienceSection extends StatefulWidget {
  const ExperienceSection({super.key});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _visible = false;
  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return VisibilityDetector(
      key: const Key('experience_section'),
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
            SectionHeader(
              label: 'Experience',
              title: 'My Professional\nJourney',
              subtitle: '${Utils.getExperience(PortfolioData.startDate)} years of shipping products that people love.',
            ),
            const SizedBox(height: 56),
            if (_visible)
              ...PortfolioData.experiences.asMap().entries.map((e) {
                return FadeInUp(
                  delay: Duration(milliseconds: e.key * 150),
                  child: _TimelineItem(
                    experience: e.value,
                    index: e.key,
                    isLast: e.key == PortfolioData.experiences.length - 1,
                    isExpanded: _expandedIndex == e.key,
                    onToggle: () {
                      setState(() {
                        _expandedIndex = _expandedIndex == e.key ? null : e.key;
                      });
                    },
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final Experience experience;
  final int index;
  final bool isLast;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _TimelineItem({
    required this.experience,
    required this.index,
    required this.isLast,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          SizedBox(
            width: isMobile ? 40 : 60,
            child: Column(
              children: [
                // Dot
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: experience.isCurrent
                        ? const LinearGradient(colors: AppColors.primaryGradient)
                        : null,
                    color: experience.isCurrent ? null : AppColors.darkBorder,
                    border: experience.isCurrent
                        ? null
                        : Border.all(color: AppColors.accent.withOpacity(0.5), width: 2),
                    boxShadow: experience.isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.accent.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ]
                        : [],
                  ),
                  child: experience.isCurrent
                      ? const Icon(Icons.circle, size: 8, color: Colors.white)
                      : null,
                ),
                // Line
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.accent.withOpacity(0.5),
                            AppColors.accent.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: GestureDetector(
              onTap: onToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isExpanded
                        ? AppColors.accent.withOpacity(0.4)
                        : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    width: isExpanded ? 1.5 : 1,
                  ),
                  boxShadow: isExpanded
                      ? [
                          BoxShadow(
                            color: AppColors.accent.withOpacity(0.08),
                            blurRadius: 20,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            experience.role,
                                            style: theme.textTheme.titleLarge,
                                          ),
                                        ),
                                        if (experience.isCurrent) ...[
                                          const SizedBox(width: 10),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                              gradient: const LinearGradient(
                                                  colors: AppColors.primaryGradient),
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: const Text(
                                              'Current',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      experience.company,
                                      style: theme.textTheme.bodyLarge?.copyWith(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            children: [
                              Row(children: [
                                Icon(Icons.calendar_today_outlined, size: 13, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  experience.duration,
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                                ),
                              ],),
                              Row(children: [
                                Icon(Icons.location_on_outlined, size: 13, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text(
                                  experience.location,
                                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
                                ),
                              ],),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Expandable content
                    AnimatedCrossFade(
                      firstChild: const SizedBox.shrink(),
                      secondChild: _ExpandedContent(experience: experience),
                      crossFadeState: isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 300),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ExpandedContent extends StatelessWidget {
  final Experience experience;
  const _ExpandedContent({required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          const SizedBox(height: 12),
          Text(
            experience.description,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.7),
          ),
          const SizedBox(height: 20),
          Text('Key Highlights', style: theme.textTheme.titleLarge?.copyWith(fontSize: 15)),
          const SizedBox(height: 12),
          ...experience.highlights.map((h) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent,
                      ),
                    ),
                    Expanded(child: Text(h, style: theme.textTheme.bodyMedium)),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: experience.techStack
                .map((t) => TechChip(label: t))
                .toList(),
          ),
        ],
      ),
    );
  }
}
