// lib/widgets/hover_card.dart
import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final Widget child;
  final double elevation;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onTap;

  const HoverCard({
    super.key,
    required this.child,
    this.elevation = 8,
    this.borderRadius,
    this.color,
    this.padding,
    this.onTap,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  bool _hovered = false;
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    setState(() => _hovered = true);
    _ctrl.forward();
  }

  void _onExit(_) {
    setState(() => _hovered = false);
    _ctrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final br = widget.borderRadius ?? BorderRadius.circular(20);
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, child) {
            return Transform.scale(
              scale: _scaleAnim.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: br,
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: const Color(0xFF6C63FF).withValues(alpha: 0.25),
                            blurRadius: 24,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [],
                ),
                padding: widget.padding,
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}
