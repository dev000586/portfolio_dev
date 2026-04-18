// lib/sections/about_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return VisibilityDetector(
      key: const Key('about_section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : 80,
          vertical: 80,
        ),
        child: isMobile
            ? _MobileAbout(visible: _visible)
            : _DesktopAbout(visible: _visible),
      ),
    );
  }
}

class _DesktopAbout extends StatelessWidget {
  final bool visible;

  const _DesktopAbout({required this.visible});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _AboutLeft(visible: visible)),
        const SizedBox(width: 80),
        Expanded(flex: 3, child: _AboutRight(visible: visible)),
      ],
    );
  }
}

class _MobileAbout extends StatelessWidget {
  final bool visible;

  const _MobileAbout({required this.visible});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AboutLeft(visible: visible),
        const SizedBox(height: 40),
        _AboutRight(visible: visible),
      ],
    );
  }
}

class _AboutLeft extends StatelessWidget {
  final bool visible;

  const _AboutLeft({required this.visible});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (visible)
          FadeInLeft(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [AppColors.darkCard, AppColors.darkSurface]
                      : [AppColors.lightSurface, AppColors.lightCard],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),
              ),
              child: Column(
                children: [
                  // Avatar placeholder
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: AppColors.primaryGradient,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        PortfolioData.name.split(' ').map((w) => w[0]).join(''),
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    PortfolioData.name,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Flutter Developer & Mobile Architect',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.accent,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 16),
                  const _InfoRow(
                      icon: Icons.location_on_outlined,
                      text: PortfolioData.location),
                  const SizedBox(height: 8),
                  const _InfoRow(
                      icon: Icons.email_outlined, text: PortfolioData.email),
                  const SizedBox(height: 8),
                  const _InfoRow(
                      icon: Icons.phone_outlined, text: PortfolioData.phone),
                ],
              ),
            ),
          ),
        const SizedBox(height: 24),
        if (visible)
          FadeInLeft(
            delay: const Duration(milliseconds: 200),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              itemCount: PortfolioData.stats.length,
              itemBuilder: (context, index) {
                return _StatCard(
                  value: PortfolioData.stats[index]['value']!,
                  label: PortfolioData.stats[index]['label']!,
                );
              },
            ),
          ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.accent),
        const SizedBox(width: 8),
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (b) => const LinearGradient(
              colors: AppColors.primaryGradient,
            ).createShader(b),
            child: Text(
              value,
              style: theme.textTheme.displaySmall?.copyWith(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _AboutRight extends StatelessWidget {
  final bool visible;

  const _AboutRight({required this.visible});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          label: 'About Me',
          title: PortfolioData.aboutTitle,
        ),
        const SizedBox(height: 28),
        if (visible)
          FadeInRight(
            delay: const Duration(milliseconds: 300),
            child: Text(
              PortfolioData.aboutDescription,
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.8),
            ),
          ),
        const SizedBox(height: 32),
        if (visible)
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: PortfolioData.aboutTags
                  .map((tag) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: AppColors.accent.withOpacity(0.3)),
                        ),
                        child: Text(
                          tag,
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: AppColors.accent,
                            fontSize: 12,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        const SizedBox(height: 36),
        if (visible)
          FadeInUp(
            delay: const Duration(milliseconds: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 25,
                  runSpacing: 25,
                  children: [
                    _ProgressItem(
                      label: 'Flutter\nDevelopment',
                      value: 0.97,
                      color: AppColors.accentOrange,
                    ),
                    _ProgressItem(
                      label: 'Architecture',
                      value: 0.94,
                      color: AppColors.accentAlt,
                    ),
                    _ProgressItem(
                      label: 'API & Backend\nIntegration',
                      value: 0.88,
                      color: AppColors.accentPink,
                    ),
                    _ProgressItem(
                      label: 'Performance\nOptimization',
                      value: 0.93,
                      color: AppColors.accentAlt,
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _ProgressItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ProgressItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        SizedBox(
          width: 64,
          height: 64,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 64,
                height: 64,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 5,
                  backgroundColor: color.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              Text(
                '${(value * 100).round()}%',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
