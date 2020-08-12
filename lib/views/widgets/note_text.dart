import 'package:flutter/material.dart';

class NoteText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  const NoteText(this.text, {this.textAlign, this.color, this.fontSize = 14,
                  this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color ?? Colors.grey[600],
      ),
    );
  }
}
