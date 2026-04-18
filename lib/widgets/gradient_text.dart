// lib/widgets/gradient_text.dart
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;
  final List<Color> colors;
  final TextStyle? style;
  final TextAlign? textAlign;

  const GradientText(
    this.text, {
    super.key,
    required this.colors,
    this.style,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}
