import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;
  final Color buttonColor;

  const MyButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.buttonColor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: buttonColor ?? Color.fromRGBO(56, 56, 68, 1),
              // Color.fromRGBO(246, 171, 54, 1)
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: buttonColor == Colors.white
                      ? Colors.black54
                      : Colors.white,
                  fontWeight: FontWeight.normal),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;
  final Color buttonColor;

  const SmallButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      this.buttonColor,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20),
        child: Container(
          height: 5,
          decoration: BoxDecoration(
              color: buttonColor ?? Color.fromRGBO(56, 56, 68, 1),
              // Color.fromRGBO(246, 171, 54, 1)
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: buttonColor == Colors.white
                      ? Colors.black54
                      : Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
