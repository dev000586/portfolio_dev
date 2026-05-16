// lib/widgets/animated_bg.dart
import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnimatedBg extends StatefulWidget {
  final Widget child;
  const AnimatedBg({super.key, required this.child});

  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, child) {
        return Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _BgPainter(_anim.value, isDark),
              ),
            ),
            child!,
          ],
        );
      },
      child: widget.child,
    );
  }
}

class _BgPainter extends CustomPainter {
  final double t;
  final bool isDark;
  _BgPainter(this.t, this.isDark);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Animated blobs
    final blobs = [
      _Blob(
        center: Offset(
          size.width * (0.2 + 0.1 * sin(t * pi)),
          size.height * (0.1 + 0.08 * cos(t * pi)),
        ),
        radius: size.width * 0.22,
        color: AppColors.accent.withValues(alpha: isDark ? 0.08 : 0.06),
      ),
      _Blob(
        center: Offset(
          size.width * (0.8 - 0.1 * cos(t * pi)),
          size.height * (0.3 + 0.1 * sin(t * pi * 1.3)),
        ),
        radius: size.width * 0.18,
        color: AppColors.accentAlt.withValues(alpha: isDark ? 0.06 : 0.05),
      ),
      _Blob(
        center: Offset(
          size.width * (0.5 + 0.08 * sin(t * pi * 0.7)),
          size.height * (0.7 + 0.05 * cos(t * pi * 1.1)),
        ),
        radius: size.width * 0.16,
        color: AppColors.accentPink.withValues(alpha: isDark ? 0.05 : 0.04),
      ),
    ];

    for (final blob in blobs) {
      paint.color = blob.color;
      paint.maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);
      canvas.drawCircle(blob.center, blob.radius, paint);
    }
  }

  @override
  bool shouldRepaint(_BgPainter old) => old.t != t || old.isDark != isDark;
}

class _Blob {
  final Offset center;
  final double radius;
  final Color color;
  _Blob({required this.center, required this.radius, required this.color});
}
