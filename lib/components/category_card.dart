import 'package:flutter/material.dart';

const kTextStyle = TextStyle(
  color: Color(0xFF7F1CFF),
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

class CategoryCard extends StatelessWidget {
  CategoryCard({
    @required this.onPress,
    this.isSelected,
    this.text,
  });

  final Function onPress;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/${text.toLowerCase()}.png'))),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    '$text',
                    style: kTextStyle,
                  ),
                ],
              ),
            ),
            isSelected
                ? Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x407f1cff),
                  ))
                : Container(),
          ],
        ),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
      ),
    );
  }
}
