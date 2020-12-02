import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double width;
  final Function onPressed;
  final Color buttonColor;

  const MyButton(
      {Key key, @required this.text, @required this.onPressed, this.buttonColor, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width ?? 200,
      child: FlatButton(
        onPressed: onPressed,
        color: buttonColor ?? Color(0xff7f1cff),
        padding: EdgeInsets.all(0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            boxShadow: buttonColor == Colors.white
                ? null
                : [
                    BoxShadow(
                      color: const Color(0x298742ff),
                      offset: Offset(0, 4),
                      blurRadius: 42,
                    ),
                  ],
          ),
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(maxWidth: double.infinity, minHeight: 50),
            child: Text(
              text,
              style: TextStyle(
                  color: buttonColor == Colors.white ? Colors.black54 : Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
