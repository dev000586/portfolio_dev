// lib/portfolio_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'services/navigation_provider.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/skills_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/achievements_section.dart';
import 'sections/contact_section.dart';
import 'widgets/navbar.dart';
import 'widgets/footer.dart';

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();

    // Map section id -> widget
    final sectionWidgets = [
      HeroSection(key: nav.sectionKeys[0]),
      AboutSection(key: nav.sectionKeys[1]),
      SkillsSection(key: nav.sectionKeys[2]),
      ExperienceSection(key: nav.sectionKeys[3]),
      ProjectsSection(key: nav.sectionKeys[4]),
      AchievementsSection(key: nav.sectionKeys[5]),
      ContactSection(key: nav.sectionKeys[6]),
    ];

    Widget updateActiveSection(Widget child, int index){
      return VisibilityDetector(
          key: Key('section_$index'),
          onVisibilityChanged: (info) {
            info.visibleFraction > 0.2 ? nav.setActiveSection(index) : null;
          },
          child: child);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const PortfolioNavBar(),
      body: SingleChildScrollView(
        controller: nav.scrollController,
        child: Column(
          children: [
            ...sectionWidgets
                .asMap()
                .entries
                .map((entry) => updateActiveSection(entry.value, entry.key)),
            const PortfolioFooter(),
          ],
        ),
      ),
      floatingActionButton: _ScrollToTopFab(nav: nav),
    );
  }
}

class _ScrollToTopFab extends StatefulWidget {
  final NavigationProvider nav;
  const _ScrollToTopFab({required this.nav});

  @override
  State<_ScrollToTopFab> createState() => _ScrollToTopFabState();
}

class _ScrollToTopFabState extends State<_ScrollToTopFab> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.nav.scrollController.addListener(() {
      final show = widget.nav.scrollController.offset > 300;
      if (show != _visible) setState(() => _visible = show);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedScale(
        scale: _visible ? 1 : 0.5,
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton(
          mini: true,
          onPressed: () => widget.nav.scrollToSection(0),
          backgroundColor: const Color(0xFF6C63FF),
          child: const Icon(Icons.keyboard_arrow_up_rounded, color: Colors.white),
        ),
      ),
    );
  }
}
