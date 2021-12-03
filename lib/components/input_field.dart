import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function validator;
  final String label;
  final int maxLength;
  final Color color;

  const TextInputField(
      {Key key,
      this.color,
      this.controller,
      this.textInputType,
      this.validator,
      this.label,
      this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextFormField(
            controller: controller,
            maxLength: maxLength,
            validator: validator,
            keyboardType: textInputType,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: label,
                labelStyle:
                    GoogleFonts.nunito(fontSize: 14, color: Colors.grey),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent))),
          ),
        ),
      ),
    );
  }
}

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function validator;
  final String label;
  final Color color;

  const PasswordInputField(
      {Key key, this.controller, this.validator, this.label, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              controller: controller,
              validator: validator,
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: label,
                  labelStyle:
                      GoogleFonts.nunito(fontSize: 14, color: Colors.grey),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
          )),
    );
  }
}
