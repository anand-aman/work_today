import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextHelper extends StatelessWidget {
  final String text;

  final double size;

  final FontWeight weight;

  final Color color;

  final double spacing;

  const TextHelper(
      {Key key,
       this.text,
     this.size,
    this.weight,
       this.color,
       this.spacing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text.toString(),
        style: GoogleFonts.nunito(
            fontSize: size,
            fontWeight: weight,
            color: color,
            letterSpacing: spacing));
  }
}
