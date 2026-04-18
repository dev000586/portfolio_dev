import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class AutoFlipWidget extends StatefulWidget {
  const AutoFlipWidget({super.key, required this.frontWidget, required this.backWidget});

  final Widget frontWidget;
  final Widget backWidget;

  @override
  State<AutoFlipWidget> createState() => _AutoFlipWidgetState();
}

class _AutoFlipWidgetState extends State<AutoFlipWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  bool isFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      flip();
    });
  }

  void flip() {
    if (isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    isFront = !isFront;
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final angle = _controller.value * pi;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspective
              ..rotateY(angle),
            child: angle <= pi / 2
                ? widget.frontWidget
                : Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: widget.backWidget,
            ),
          );
        },
      ),
    );
  }
}