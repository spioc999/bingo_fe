import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {

  final String? text;
  final double fontSize;
  final Color color;
  final List<Shadow>? shadows;
  final int maxLines;
  final TextAlign textAlign;
  final TextDecoration decoration;


  const BoldText(this.text, {this.fontSize = 14, this.color = Colors.black, this.shadows,
    this.maxLines = 1, this.textAlign = TextAlign.left, this.decoration = TextDecoration.none, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.w700,
          decoration: decoration
      ),
    );
  }
}
