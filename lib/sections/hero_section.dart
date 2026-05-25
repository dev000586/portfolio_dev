// lib/sections/hero_section.dart
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_portfolio/utils/utils.dart';
import 'package:flutter_portfolio/widgets/auto_flip_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/image_constants.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../services/navigation_provider.dart';
import '../widgets/animated_bg.dart';
import '../widgets/gradient_text.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final nav = context.read<NavigationProvider>();

    return AnimatedBg(
      child: Container(
        constraints: BoxConstraints(minHeight: size.height),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 24 : 80,
              vertical: 80,
            ),
            child: isMobile
                ? _MobileHero(nav: nav)
                : _DesktopHero(nav: nav),
          ),
        ),
      ),
    );
  }
}

class _DesktopHero extends StatelessWidget {
  final NavigationProvider nav;
  const _DesktopHero({required this.nav});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _HeroText(nav: nav)),
        const SizedBox(width: 60),
        Expanded(flex: 2, child: _HeroAvatar()),
      ],
    );
  }
}

class _MobileHero extends StatelessWidget {
  final NavigationProvider nav;
  const _MobileHero({required this.nav});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeroAvatar(),
        const SizedBox(height: 40),
        _HeroText(nav: nav),
      ],
    );
  }
}

class _HeroText extends StatelessWidget {
  final NavigationProvider nav;
  const _HeroText({required this.nav});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 700),
          child: Text(
            'Hello, I\'m',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w600,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        FadeInDown(
          delay: const Duration(milliseconds: 200),
          child: GradientText(
            PortfolioData.name,
            colors: AppColors.heroGradient,
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: isMobile ? 42 : 72,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(height: 16),
        FadeInDown(
          delay: const Duration(milliseconds: 400),
          child: Row(
            children: [
              Text(
                '— ',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.accentAlt,
                ),
              ),
              Flexible(
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: PortfolioData.roles
                      .map((r) => TyperAnimatedText(
                            r,
                            speed: const Duration(milliseconds: 65),
                            textStyle: theme.textTheme.headlineSmall?.copyWith(
                              color: AppColors.accentAlt,
                              fontSize: width < 950 ? 16 : null
                            ),
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        FadeInUp(
          delay: const Duration(milliseconds: 500),
          child: Text(
            '${PortfolioData.aboutDescription.split('. ').take(2).join('. ')}.',
            style: theme.textTheme.bodyLarge?.copyWith(
              height: 1.7,
              fontSize: 15,
            ),
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 36),
        FadeInUp(
          delay: const Duration(milliseconds: 600),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _PrimaryButton(
                label: 'View Projects',
                onTap: () => nav.scrollToSection(4),
              ),
              _OutlineButton(
                label: 'Contact Me',
                onTap: () => nav.scrollToSection(6),
              ),
              _OutlineButton(
                label: '↓ Resume',
                onTap: () => launchUrl(Uri.parse(PortfolioData.resumeUrl)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
        FadeInUp(
          delay: const Duration(milliseconds: 700),
          child: _SocialRow(),
        ),
      ],
    );
  }
}

class _HeroAvatar extends StatefulWidget {
  @override
  State<_HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<_HeroAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 3))
      ..repeat(reverse: true);
    _float = Tween<double>(begin: -10, end: 10)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final avatarSize = size.width < 768 ? 200.0 : size.width * 1/4;

    return AnimatedBuilder(
      animation: _float,
      builder: (_, child) => Transform.translate(
        offset: Offset(0, _float.value),
        child: child,
      ),
      child: FadeInRight(
        duration: const Duration(milliseconds: 800),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              AutoFlipWidget(
                  frontWidget: _buildAvatarFrame(avatarSize, isFront: true),
                  backWidget: _buildAvatarFrame(avatarSize, isFront: false)),
              // Floating badge
              Positioned(
                bottom: 20,
                right: 40,
                child: _FloatingBadge(label: Utils.getExperience(PortfolioData.startDate), icon: const Icon(Icons.code, size: 14,)),
              ),
              Positioned(
                top: 20,
                left: 0,
                child: _FloatingBadge(label: 'Flutter Developer', icon: Image.asset(ImageConst.flutterIcon, width: 14, height: 14,)),
              ),
            ],
          ),
        )
      ),
    );
  }

  Widget _buildAvatarFrame(avatarSize, {bool isFront = true}) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Glow rings
        Container(
          width: avatarSize + 60,
          height: avatarSize + 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accent.withValues(alpha: 0.15),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Container(
          width: avatarSize + 20,
          height: avatarSize + 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.accent.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
        ),
        // Avatar
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF6C63FF), Color(0xFF00E5FF)],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.4),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: _buildAvatar(avatarSize, isFront: isFront),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(double size, {bool isFront = true}) {
    // Use initials avatar since we don't have a real image
    return isFront ? Image.asset(ImageConst.avatarAsset, fit: BoxFit.fitWidth, height: size, width: size,)
      : Image.asset(ImageConst.avatarBackAsset, fit: BoxFit.fitWidth, height: size, width: size,);
  }
}

class _FloatingBadge extends StatelessWidget {
  final String label;
  final Widget icon;

  const _FloatingBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.darkBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final iconMap = {
      'github': FontAwesomeIcons.github,
      'linkedin': FontAwesomeIcons.linkedin,
      'twitter': FontAwesomeIcons.xTwitter,
      'medium': FontAwesomeIcons.medium,
      'youtube': FontAwesomeIcons.youtube,
    };

    return Wrap(
      spacing: 16,
      children: PortfolioData.socialLinks.map((s) {
        return _SocialIcon(
          icon: iconMap[s.icon] ?? FontAwesomeIcons.link,
          url: s.url,
          label: s.label,
        );
      }).toList(),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;
  const _SocialIcon({required this.icon, required this.url, required this.label});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Tooltip(
          message: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.15)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hovered ? AppColors.accent : AppColors.darkBorder,
              ),
            ),
            child: FaIcon(
              widget.icon,
              size: 18,
              color: _hovered ? AppColors.accent : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: AppColors.primaryGradient),
            borderRadius: BorderRadius.circular(14),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovered
                  ? AppColors.accent
                  : (isDark ? Colors.white70 : Colors.black87),
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
