import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  const BoldText(
      {super.key,
      required this.title,
      this.fontSize = 14,
      this.color = const Color(0xFF272727)});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.w600, fontSize: fontSize, color: color),
    );
  }
}
