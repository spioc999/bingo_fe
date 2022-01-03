import 'package:flutter/material.dart';

class RomanText extends StatelessWidget {

  final String? text;
  final double fontSize;
  final Color color;
  final int maxLines;
  final TextAlign textAlign;
  final TextDecoration decoration;


  const RomanText(this.text, {this.fontSize = 14, this.color = Colors.black, this.maxLines = 1,
    this.textAlign = TextAlign.left, this.decoration = TextDecoration.none, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: FontWeight.w400,
          decoration: decoration
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.fade,
    );
  }
}
