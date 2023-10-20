import 'package:flutter/material.dart';

class RegularText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final TextAlign align;
  const RegularText({
    super.key,
    required this.title,
    this.fontSize = 14,
    this.color = const Color(0xFF272727),
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: align,
      style: TextStyle(
          fontWeight: FontWeight.w400, fontSize: fontSize, color: color),
    );
  }
}
