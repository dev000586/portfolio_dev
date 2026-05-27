import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/utils/utils.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/portfolio_data.dart';
import '../services/navigation_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import '../widgets/tech_chip.dart';

const int _kInitialProjectCount = 4;

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  bool _visible = false;
  ProjectCategory? _selectedFilter;
  bool _expanded = false;

  List<Project> get _filtered => _selectedFilter == null
      ? PortfolioData.projects
      : PortfolioData.projects
      .where((p) => p.categories.contains(_selectedFilter))
      .toList();

  List<Project> get _visibleProjects =>
      _expanded ? _filtered : _filtered.take(_kInitialProjectCount).toList();

  bool get _hasMore => _filtered.length > _kInitialProjectCount;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('projects_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
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
              label: 'Projects',
              title: 'Things I\'ve\nBuilt',
              subtitle:
              'A selection of apps and tools I\'ve crafted with passion.',
            ),
            const SizedBox(height: 40),
            // Filter chips
            if (_visible)
              FadeInUp(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FilterChip(
                        label: 'All',
                        selected: _selectedFilter == null,
                        onTap: () => setState(() {
                          _selectedFilter = null;
                          _expanded = false;
                        }),
                      ),
                      ...ProjectCategory.values.map((c) => _FilterChip(
                        label: _categoryLabel(c),
                        selected: _selectedFilter == c,
                        onTap: () => setState(() {
                          _selectedFilter = c;
                          _expanded = false;
                        }),
                      )),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 40),
            // Projects grid
            if (_visible)
              isMobile
                  ? _MobileProjects(
                key: ValueKey('${_selectedFilter}_$_expanded'),
                projects: _visibleProjects,
                visible: _visible,
              )
                  : _DesktopProjects(
                key: ValueKey('${_selectedFilter}_$_expanded'),
                projects: _visibleProjects,
                visible: _visible,
              ),
            // Show More / Show Less Button
            if (_visible && _hasMore) ...[
              const SizedBox(height: 40),
              FadeInUp(
                child: Center(
                  child: _ExpandButton(
                    expanded: _expanded,
                    remainingCount: _filtered.length - _kInitialProjectCount,
                    onTap: () {
                      final wasExpanded = _expanded;
                      setState(() => _expanded = !_expanded);

                      // Only scroll up when collapsing
                      if (wasExpanded) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          final nav = context.read<NavigationProvider>();
                          final ctx = nav.sectionKeys[_kInitialProjectCount].currentContext;
                          if (ctx != null) {
                            Scrollable.ensureVisible(
                              ctx,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              alignment: 0.0, // 0.0 = top of viewport
                            );
                          }
                        });
                      }
                    }
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _categoryLabel(ProjectCategory c) {
    switch (c) {
      case ProjectCategory.mobile:
        return 'Mobile';
      case ProjectCategory.web:
        return 'Web';
      case ProjectCategory.desktop:
        return 'Desktop';
      case ProjectCategory.openSource:
        return 'Open Source';
    }
  }
}

// ─── Expand / Collapse Button ────────────────────────────────────────────────

class _ExpandButton extends StatefulWidget {
  final bool expanded;
  final int remainingCount;
  final VoidCallback onTap;

  const _ExpandButton({
    required this.expanded,
    required this.remainingCount,
    required this.onTap,
  });

  @override
  State<_ExpandButton> createState() => _ExpandButtonState();
}

class _ExpandButtonState extends State<_ExpandButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hovered = false);
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding:
          const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: _hovered
                ? null
                : (isDark ? AppColors.darkCard : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: _hovered
                  ? Colors.transparent
                  : AppColors.accent.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: _hovered
                ? [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.25),
                blurRadius: 20,
                spreadRadius: 2,
              )
            ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: widget.expanded ? 0.5 : 0,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 20,
                  color: _hovered
                      ? Colors.white
                      : AppColors.accent,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _hovered ? Colors.white : AppColors.accent,
                ),
                child: Text(
                  widget.expanded
                      ? 'Show Less'
                      : 'Show ${widget.remainingCount} More Project${widget.remainingCount == 1 ? '' : 's'}',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Filter Chip ─────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
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
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}

// ─── Desktop Projects ─────────────────────────────────────────────────────────

class _DesktopProjects extends StatelessWidget {
  final List<Project> projects;
  final bool visible;

  const _DesktopProjects(
      {super.key, required this.projects, required this.visible});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) return const _EmptyState();

    final featured = projects.where((p) => p.featured).toList();
    final regular = projects.where((p) => !p.featured).toList();

    return Column(
      children: [
        // Featured projects (large)
        ...featured.asMap().entries.map((e) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: FadeInUp(
              key: ValueKey(e.value.title),
              delay: Duration(milliseconds: e.key * 150),
              child: SizedBox(
                width: double.infinity,
                child: _FeaturedProjectCard(project: e.value),
              ),
            ),
          );
        }),
        // Regular projects (masonry grid)
        if (regular.isNotEmpty)
          MasonryGridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            itemCount: regular.length,
            itemBuilder: (context, index) {
              return FadeInUp(
                key: ValueKey(regular[index].title),
                delay: Duration(milliseconds: (index + featured.length) * 150),
                child: SizedBox(
                  width: double.infinity,
                  child: _RegularProjectCard(project: regular[index]),
                ),
              );
            },
          ),
      ],
    );
  }
}

// ─── Mobile Projects ──────────────────────────────────────────────────────────

class _MobileProjects extends StatelessWidget {
  final List<Project> projects;
  final bool visible;

  const _MobileProjects(
      {super.key, required this.projects, required this.visible});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) return const _EmptyState();
    return Column(
      children: projects.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: FadeInUp(
            key: ValueKey(e.value.title),
            delay: Duration(milliseconds: e.key * 100),
            child: _RegularProjectCard(project: e.value),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Featured Project Card ────────────────────────────────────────────────────

class _FeaturedProjectCard extends StatefulWidget {
  final Project project;

  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hovered = false);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.4)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: _hovered ? 1.5 : 1,
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.12),
                blurRadius: 30,
                spreadRadius: 3)
          ]
              : [],
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Image side
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(24)),
                  child: _ProjectImagePlaceholder(project: p, height: 280),
                ),
              ),
              // Content side
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: p.categories
                                .map((category) =>
                                _CategoryBadge(category: category))
                                .toList(),
                          ),
                          const Spacer(),
                          if (p.featured)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                AppColors.accentOrange.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: AppColors.accentOrange
                                        .withValues(alpha: 0.3)),
                              ),
                              child: const Text(
                                '⭐ Featured',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: AppColors.accentOrange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: Image.asset(p.imageAsset, height: 30, width: 30,
                            errorBuilder: (context, error, stackTrace) {
                              return FutureBuilder(
                                future: Utils.generatePalette(widget.project.imageAsset),
                                builder: (context, asyncSnapshot) {
                                  return Container(
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: asyncSnapshot.data != null ? asyncSnapshot.data! : AppColors.getProjectGradient(p.categories),
                                      ),
                                    ),
                                    child: Text(p.title.substring(0, 1,).toUpperCase(),
                                    style: theme.textTheme.headlineSmall,),
                                  );
                                }
                              );
                            },),
                          ),
                          const SizedBox(width: 8),
                          Text(p.title, style: theme.textTheme.headlineMedium),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.subtitle,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: AppColors.accent),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        p.description,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(height: 1.7),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      const Spacer(),
                      // Stats
                      Row(
                        children: p.stats.entries
                            .map((s) => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.value,
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                              Text(s.key,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontSize: 11)),
                            ],
                          ),
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: p.techStack
                            .take(4)
                            .map((t) => TechChip(label: t))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          if (p.githubUrl.isNotEmpty)
                            _ActionButton(
                              icon: FontAwesomeIcons.github,
                              label: 'GitHub',
                              onTap: () =>
                                  launchUrl(Uri.parse(p.githubUrl)),
                            ),
                          const SizedBox(width: 12),
                          if (p.liveUrl.isNotEmpty)
                            _ActionButton(
                              icon: Icons.open_in_new,
                              label: 'Live',
                              onTap: () =>
                                  launchUrl(Uri.parse(p.liveUrl)),
                              isPrimary: true,
                            ),
                          const SizedBox(width: 12),
                          if (p.androidUrl.isNotEmpty)
                            _ActionButton(
                              icon: Icons.android,
                              label: 'Android',
                              onTap: () =>
                                  launchUrl(Uri.parse(p.androidUrl)),
                              isPrimary: true,
                            ),
                          const SizedBox(width: 12),
                          if (p.iosUrl.isNotEmpty)
                            _ActionButton(
                              icon: Icons.apple,
                              label: 'IOS',
                              onTap: () =>
                                  launchUrl(Uri.parse(p.iosUrl)),
                              isPrimary: true,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Regular Project Card ─────────────────────────────────────────────────────

class _RegularProjectCard extends StatefulWidget {
  final Project project;

  const _RegularProjectCard({required this.project});

  @override
  State<_RegularProjectCard> createState() => _RegularProjectCardState();
}

class _RegularProjectCardState extends State<_RegularProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _hovered = false);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: Matrix4.identity()
          ..translateByDouble(0.0, _hovered ? -4.0 : 0.0, 0.0, 1.0),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.4)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          ),
          boxShadow: _hovered
              ? [
            BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.12),
                blurRadius: 20,
                offset: const Offset(0, 8))
          ]
              : [],
        ),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
                child: _ProjectImagePlaceholder(project: p, height: 160),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: p.categories
                                .map((category) =>
                                _CategoryBadge(category: category))
                                .toList(),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              if (p.githubUrl.isNotEmpty)
                                IconButton(
                                  onPressed: () =>
                                      launchUrl(Uri.parse(p.githubUrl)),
                                  icon: const FaIcon(
                                      FontAwesomeIcons.github,
                                      size: 16),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              const SizedBox(width: 8),
                              if (p.liveUrl.isNotEmpty)
                                IconButton(
                                  onPressed: () =>
                                      launchUrl(Uri.parse(p.liveUrl)),
                                  icon: const Icon(Icons.open_in_new,
                                      size: 16),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              const SizedBox(width: 8),
                              if (p.androidUrl.isNotEmpty)
                                IconButton(
                                  onPressed: () =>
                                      launchUrl(Uri.parse(p.androidUrl)),
                                  icon: const FaIcon(
                                      FontAwesomeIcons.android,
                                      size: 16),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              const SizedBox(width: 8),
                              if (p.iosUrl.isNotEmpty)
                                IconButton(
                                  onPressed: () =>
                                      launchUrl(Uri.parse(p.iosUrl)),
                                  icon: const FaIcon(
                                      FontAwesomeIcons.apple,
                                      size: 16),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            child: Image.asset(p.imageAsset, height: 30, width: 30,
                              errorBuilder: (context, error, stackTrace) {
                                return FutureBuilder(
                                  future: Utils.generatePalette(widget.project.imageAsset),
                                  builder: (context, asyncSnapshot) {
                                    return Container(
                                      height: 30,
                                      width: 30,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: asyncSnapshot.data != null ? asyncSnapshot.data! : AppColors.getProjectGradient(p.categories),
                                        ),
                                      ),
                                      child: Text(p.title.substring(0, 1,).toUpperCase(),
                                        style: theme.textTheme.titleMedium,),
                                    );
                                  }
                                );
                              },),
                          ),
                          const SizedBox(width: 8),
                          Text(p.title, style: theme.textTheme.titleLarge),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        p.subtitle,
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: AppColors.accent),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: Text(
                          p.description,
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(height: 1.6),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Stats
                      Wrap(
                        runSpacing: 5,
                        children: p.stats.entries
                            .map((s) => Padding(
                          padding: const EdgeInsets.only(right: 24),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.value,
                                style: theme.textTheme.titleLarge
                                    ?.copyWith(
                                  color: AppColors.accent,
                                ),
                              ),
                              Text(s.key,
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontSize: 11)),
                            ],
                          ),
                        ))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: p.techStack
                            .take(3)
                            .map((t) => TechChip(label: t))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Project Image Placeholder ────────────────────────────────────────────────

class _ProjectImagePlaceholder extends StatelessWidget {
  final Project project;
  final double height;

  const _ProjectImagePlaceholder(
      {required this.project, required this.height});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Utils.generatePalette(project.imageAsset),
      builder: (context, asyncSnapshot) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: asyncSnapshot.data != null ? asyncSnapshot.data! : AppColors.getProjectGradient(project.categories),
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: project.categories
                          .map((category) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          _categoryIcon(category),
                          size: 48,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ))
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      project.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -20,
                right: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
              Positioned(
                bottom: -30,
                left: -30,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.05),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  IconData _categoryIcon(ProjectCategory cat) {
    switch (cat) {
      case ProjectCategory.mobile:
        return Icons.phone_android;
      case ProjectCategory.web:
        return Icons.web;
      case ProjectCategory.desktop:
        return Icons.desktop_mac;
      case ProjectCategory.openSource:
        return Icons.code;
    }
  }
}

// ─── Category Badge ───────────────────────────────────────────────────────────

class _CategoryBadge extends StatelessWidget {
  final ProjectCategory category;

  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final data = {
      ProjectCategory.mobile: ('Mobile', AppColors.accent),
      ProjectCategory.web: ('Web', AppColors.accentGreen),
      ProjectCategory.desktop: ('Desktop', AppColors.accentOrange),
      ProjectCategory.openSource: ('Open Source', AppColors.accentPink),
    };
    final d = data[category]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: d.$2.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: d.$2.withValues(alpha: 0.3)),
      ),
      child: Text(
        d.$1,
        style: TextStyle(
            fontSize: 11, color: d.$2, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// ─── Action Button ────────────────────────────────────────────────────────────

class _ActionButton extends StatelessWidget {
  final dynamic icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          gradient: isPrimary
              ? const LinearGradient(colors: AppColors.primaryGradient)
              : null,
          color: isPrimary ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border:
          isPrimary ? null : Border.all(color: AppColors.darkBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon is IconData
                ? Icon(icon as IconData, size: 14, color: Colors.white)
                : FaIcon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(
          children: [
            Icon(Icons.folder_open, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text('No projects in this category',
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}