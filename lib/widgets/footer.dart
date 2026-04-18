// lib/widgets/footer.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

class PortfolioFooter extends StatelessWidget {
  const PortfolioFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;
    final theme = Theme.of(context);

    final iconMap = {
      'github': FontAwesomeIcons.github,
      'linkedin': FontAwesomeIcons.linkedin,
      'twitter': FontAwesomeIcons.xTwitter,
      'medium': FontAwesomeIcons.medium,
      'youtube': FontAwesomeIcons.youtube,
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 80, vertical: 40),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightCard,
        border: Border(
          top: BorderSide(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                  children: [
                    _FooterBrand(),
                    const SizedBox(height: 24),
                    _SocialIcons(iconMap: iconMap),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _FooterBrand(),
                    _SocialIcons(iconMap: iconMap),
                  ],
                ),
          const SizedBox(height: 24),
          Divider(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
          const SizedBox(height: 16),
          Text(
            '© ${DateTime.now().year} ${PortfolioData.name}. Built with ❤️ using Flutter.',
            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FooterBrand extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: AppColors.primaryGradient),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  PortfolioData.name.split(' ').map((w) => w[0]).join(''),
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(PortfolioData.name, style: theme.textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Flutter Developer & Mobile Architect',
          style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.accent, fontSize: 13),
        ),
      ],
    );
  }
}

class _SocialIcons extends StatelessWidget {
  final Map<String, IconData> iconMap;
  const _SocialIcons({required this.iconMap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: PortfolioData.socialLinks.map((s) {
        return Padding(
          padding: const EdgeInsets.only(left: 12),
          child: _FooterSocialIcon(
            icon: iconMap[s.icon] ?? FontAwesomeIcons.link,
            url: s.url,
            label: s.label,
          ),
        );
      }).toList(),
    );
  }
}

class _FooterSocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final String label;

  const _FooterSocialIcon({required this.icon, required this.url, required this.label});

  @override
  State<_FooterSocialIcon> createState() => _FooterSocialIconState();
}

class _FooterSocialIconState extends State<_FooterSocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: Tooltip(
          message: widget.label,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _hovered ? AppColors.accent.withOpacity(0.12) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: _hovered ? AppColors.accent : AppColors.darkBorder,
              ),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                size: 15,
                color: _hovered ? AppColors.accent : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
