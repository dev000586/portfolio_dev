// lib/sections/contact_section.dart
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../services/contact_service.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return VisibilityDetector(
      key: const Key('contact_section'),
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
              label: 'Contact',
              title: 'Let\'s Work\nTogether',
              subtitle: 'Have a project in mind? I\'d love to hear about it.',
            ),
            const SizedBox(height: 56),
            if (_visible)
              isMobile
                  ? _MobileContact()
                  : _DesktopContact(),
          ],
        ),
      ),
    );
  }
}

class _DesktopContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _ContactInfo()),
        const SizedBox(width: 60),
        Expanded(flex: 3, child: _ContactForm()),
      ],
    );
  }
}

class _MobileContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ContactInfo(),
        const SizedBox(height: 40),
        _ContactForm(),
      ],
    );
  }
}

class _ContactInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final iconMap = {
      'github': FontAwesomeIcons.github,
      'linkedin': FontAwesomeIcons.linkedin,
      'twitter': FontAwesomeIcons.xTwitter,
      'medium': FontAwesomeIcons.medium,
      'youtube': FontAwesomeIcons.youtube,
    };

    return FadeInLeft(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Info cards
          _ContactInfoCard(
            icon: Icons.email_outlined,
            label: 'Email',
            value: PortfolioData.email,
            onTap: () => launchUrl(Uri.parse('mailto:${PortfolioData.email}')),
          ),
          const SizedBox(height: 16),
          _ContactInfoCard(
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: PortfolioData.phone,
            onTap: () => launchUrl(Uri.parse('tel:${PortfolioData.phone}')),
          ),
          const SizedBox(height: 16),
          const _ContactInfoCard(
            icon: Icons.location_on_outlined,
            label: 'Location',
            value: PortfolioData.location,
            onTap: null,
          ),
          const SizedBox(height: 40),
          Text('Find me on', style: theme.textTheme.titleLarge),
          const SizedBox(height: 20),
          Wrap(
            spacing: 14,
            runSpacing: 14,
            children: PortfolioData.socialLinks.map((s) {
              return _SocialCardButton(
                icon: iconMap[s.icon]?.data ?? FontAwesomeIcons.link.data,
                label: s.label,
                url: s.url,
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          // Availability badge
         /* Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.accentGreen.withValues(alpha: 0.1),
                  AppColors.accent.withValues(alpha: 0.1),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.accentGreen.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGreen,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGreen,
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Available for Freelance',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 15,
                          color: AppColors.accentGreen,
                        ),
                      ),
                      Text(
                        'Open to exciting new projects',
                        style: theme.textTheme.bodyMedium?.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
        ],
      ),
    );
  }
}

class _ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ContactInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  State<_ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<_ContactInfoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : AppColors.lightSurface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent.withValues(alpha: 0.4)
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(widget.icon, color: AppColors.accent, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.label,
                      style: theme.textTheme.bodyMedium?.copyWith(fontSize: 11),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.value,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 14,
                          color: _hovered ? AppColors.accent : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialCardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String url;

  const _SocialCardButton({
    required this.icon,
    required this.label,
    required this.url,
  });

  @override
  State<_SocialCardButton> createState() => _SocialCardButtonState();
}

class _SocialCardButtonState extends State<_SocialCardButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.12)
                : (isDark ? AppColors.darkCard : AppColors.lightSurface),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: _hovered
                  ? AppColors.accent
                  : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FaIconData(widget.icon),
                size: 15,
                color: _hovered ? AppColors.accent : Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  color: _hovered ? AppColors.accent : Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Contact Form ──────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  // final _emailCtrl = TextEditingController();
  final _msgCtrl = TextEditingController();

  bool _loading = false;
  String? _result; // 'success' | 'error'

  final cfg = PortfolioData.contactFormConfig;

  @override
  void dispose() {
    _nameCtrl.dispose();
    // _emailCtrl.dispose();
    _msgCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _loading = true; _result = null; });

    final ok = await ContactService.sendMessage(
      name: _nameCtrl.text.trim(),
      message: _msgCtrl.text.trim(),
    );

    setState(() {
      _loading = false;
      _result = ok ? 'success' : 'error';
    });

    if (ok) {
      _nameCtrl.clear();
      // _emailCtrl.clear();
      _msgCtrl.clear();
    }

    if (mounted && !ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ok ? cfg.successMessage : cfg.errorMessage),
          backgroundColor: ok ? AppColors.accentGreen : AppColors.accentPink,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(24),
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeInRight(
      child: Container(
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send Me a Message',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Feel free to reach out—I\'ll respond as soon as possible.',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 32),

              // Name
              _AnimatedFormField(
                controller: _nameCtrl,
                label: cfg.nameLabel,
                hint: cfg.namePlaceholder,
                prefixIcon: Icons.person_outline,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Name is required';
                  if (v.trim().length < 2) return 'Name is too short';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // // Email
              // _AnimatedFormField(
              //   controller: _emailCtrl,
              //   label: cfg.emailLabel,
              //   hint: cfg.emailPlaceholder,
              //   prefixIcon: Icons.email_outlined,
              //   keyboardType: TextInputType.emailAddress,
              //   validator: (v) {
              //     if (v == null || v.trim().isEmpty) return 'Email is required';
              //     final emailRx = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              //     if (!emailRx.hasMatch(v.trim())) return 'Enter a valid email address';
              //     return null;
              //   },
              // ),
              // const SizedBox(height: 20),

              // Message
              _AnimatedFormField(
                controller: _msgCtrl,
                label: cfg.messageLabel,
                hint: cfg.messagePlaceholder,
                prefixIcon: Icons.message_outlined,
                maxLines: 5,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Message is required';
                  if (v.trim().length < 20) return 'Message must be at least 20 characters';
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: _SubmitButton(
                  loading: _loading,
                  label: cfg.submitLabel,
                  onTap: _loading ? null : _submit,
                ),
              ),

              // Result feedback
              if (_result != null && _result != 'success') ...[
                const SizedBox(height: 16),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: (_result == 'success' ? AppColors.accentGreen : AppColors.accentPink)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (_result == 'success' ? AppColors.accentGreen : AppColors.accentPink)
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _result == 'success' ? Icons.check_circle_outline : Icons.error_outline,
                        color: _result == 'success' ? AppColors.accentGreen : AppColors.accentPink,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _result == 'success' ? cfg.successMessage : cfg.errorMessage,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: _result == 'success' ? AppColors.accentGreen : AppColors.accentPink,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Animated Form Field ────────────────────────────────────────

class _AnimatedFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData prefixIcon;
  final int maxLines;
  final String? Function(String?)? validator;

  const _AnimatedFormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.maxLines = 1,
    this.validator,
  });

  @override
  State<_AnimatedFormField> createState() => _AnimatedFormFieldState();
}

class _AnimatedFormFieldState extends State<_AnimatedFormField> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Focus(
      onFocusChange: (f) => setState(() => _focused = f),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: _focused
              ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.15), blurRadius: 12, spreadRadius: 1)]
              : [],
        ),
        child: TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          validator: widget.validator,
          style: TextStyle(
            color: isDark ? Colors.white : const Color(0xFF1A1A2E),
            fontSize: 15,
          ),

          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            prefixIcon: Icon(
              widget.prefixIcon,
              color: _focused ? AppColors.accent : Colors.grey,
              size: 20,
            ),
            alignLabelWithHint: widget.maxLines > 1,
          ),
        ),
      ),
    );
  }
}

// ── Submit Button ──────────────────────────────────────────────

class _SubmitButton extends StatefulWidget {
  final bool loading;
  final String label;
  final VoidCallback? onTap;

  const _SubmitButton({
    required this.loading,
    required this.label,
    this.onTap,
  });

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
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
          height: 54,
          decoration: BoxDecoration(
            gradient: widget.onTap != null
                ? const LinearGradient(colors: AppColors.primaryGradient)
                : null,
            color: widget.onTap == null ? Colors.grey.withValues(alpha: 0.3) : null,
            borderRadius: BorderRadius.circular(14),
            boxShadow: _hovered && widget.onTap != null
                ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 6))]
                : [],
          ),
          child: Center(
            child: widget.loading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
