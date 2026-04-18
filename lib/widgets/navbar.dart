// lib/widgets/navbar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../theme/theme_provider.dart';
import '../services/navigation_provider.dart';

class PortfolioNavBar extends StatefulWidget implements PreferredSizeWidget {
  const PortfolioNavBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final nav = context.read<NavigationProvider>();
      nav.scrollController.addListener(() {
        final isScrolled = nav.scrollController.offset > 50;
        if (isScrolled != _scrolled && mounted) {
          setState(() => _scrolled = isScrolled);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final navProvider = context.watch<NavigationProvider>();
    final isDark = themeProvider.isDark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 70,
      decoration: BoxDecoration(
        color: _scrolled
            ? (isDark
                ? AppColors.darkSurface.withOpacity(0.96)
                : AppColors.lightSurface.withOpacity(0.96))
            : Colors.transparent,
        border: _scrolled
            ? Border(
                bottom: BorderSide(
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                  width: 1,
                ),
              )
            : null,
        boxShadow: _scrolled
            ? [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20)]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
        child: Row(
          children: [
            // Logo
            GestureDetector(
              onTap: () => navProvider.scrollToSection(0),
              child: _Logo(isDark: isDark),
            ),
            const SizedBox(width: 10,),
            // Nav items — desktop only
            if (!isMobile)
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  width: double.maxFinite,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: PortfolioData.sections
                          .where((s) => s.visible)
                          .toList()
                          .asMap()
                          .entries
                          .map((e) => _NavItem(
                                label: e.value.label,
                                index: e.key,
                                active: navProvider.activeSection == e.key,
                                isDark: isDark,
                                onTap: () => navProvider.scrollToSection(e.key),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              )
            else
              const Spacer(),
            const SizedBox(width: 16),
            if (!isMobile) _ResumeButton(),
            const SizedBox(width: 12),
            _ThemeToggle(isDark: isDark, onToggle: themeProvider.toggleTheme),
            if (isMobile) _MobileMenuButton(navProvider: navProvider),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final bool isDark;
  const _Logo({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              PortfolioData.name.split(' ').map((w) => w[0]).join(''),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          PortfolioData.name.split(' ').first,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: isDark ? Colors.white : const Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final int index;
  final bool active;
  final bool isDark;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.index,
    required this.active,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: widget.active
                ? AppColors.accent.withOpacity(0.12)
                : (_hovered ? AppColors.accent.withOpacity(0.06) : Colors.transparent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: widget.active ? FontWeight.w600 : FontWeight.w400,
              color: widget.active
                  ? AppColors.accent
                  : (widget.isDark ? Colors.white70 : Colors.black87),
            ),
          ),
        ),
      ),
    );
  }
}

class _ResumeButton extends StatefulWidget {
  @override
  State<_ResumeButton> createState() => _ResumeButtonState();
}

class _ResumeButtonState extends State<_ResumeButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(PortfolioData.resumeUrl)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          decoration: BoxDecoration(
            gradient: _hovered
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: _hovered ? null : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered ? Colors.transparent : AppColors.accent,
              width: 1.5,
            ),
          ),
          child: Text(
            'Resume ↓',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _hovered ? Colors.white : AppColors.accent,
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const _ThemeToggle({required this.isDark, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Tooltip(
        message: isDark ? 'Switch to Light' : 'Switch to Dark',
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 46,
          height: 26,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment:
                    isDark ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.all(2),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: AppColors.primaryGradient),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.light_mode,
                    size: 12,
                    color: Colors.white,
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

class _MobileMenuButton extends StatelessWidget {
  final NavigationProvider navProvider;
  const _MobileMenuButton({required this.navProvider});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (_) => _MobileMenu(navProvider: navProvider),
        );
      },
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final NavigationProvider navProvider;
  const _MobileMenu({required this.navProvider});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final sections =
        PortfolioData.sections.where((s) => s.visible).toList();

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          ...sections.asMap().entries.map(
                (e) => ListTile(
                  title: Text(
                    e.value.label,
                    style: TextStyle(
                      fontWeight: navProvider.activeSection == e.key
                          ? FontWeight.w700
                          : FontWeight.w400,
                      color: navProvider.activeSection == e.key
                          ? AppColors.accent
                          : null,
                    ),
                  ),
                  trailing: navProvider.activeSection == e.key
                      ? const Icon(Icons.arrow_right_alt,
                          color: AppColors.accent)
                      : null,
                  onTap: () {
                    Navigator.pop(context);
                    navProvider.scrollToSection(e.key);
                  },
                ),
              ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => launchUrl(Uri.parse(PortfolioData.resumeUrl)),
              icon: const Icon(Icons.download, size: 16),
              label: const Text('Download Resume'),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
