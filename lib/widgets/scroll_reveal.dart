// lib/widgets/scroll_reveal.dart
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ScrollReveal extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset fromOffset;
  final String visibilityKey;

  const ScrollReveal({
    super.key,
    required this.child,
    required this.visibilityKey,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.fromOffset = const Offset(0, 30),
  });

  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _triggered = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: widget.duration);
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _slide = Tween<Offset>(begin: widget.fromOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _trigger() {
    if (_triggered) return;
    _triggered = true;
    Future.delayed(widget.delay, () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.visibilityKey),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.15) _trigger();
      },
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, child) => Opacity(
          opacity: _opacity.value,
          child: Transform.translate(
            offset: _slide.value,
            child: child,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
