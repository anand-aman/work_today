import 'package:flutter/material.dart';

final kSpacingUnit = 10.00;

const kSilverColor = const Color(0xFFF6F7FB);
const kAccentColor = const Color(0xFFED5575);
const kPrimaryTextColor = const Color(0xFF211D42);
const kSecondaryTextColor = const Color(0xFFB9B8CD);

final kCardShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.05),
  blurRadius: 20,
  offset: Offset(10, 10),
);

final kFooterShadow = BoxShadow(
  color: Color.fromRGBO(0, 0, 0, 0.10),
  blurRadius: 50,
  offset: Offset(0, -10),
);

final kHeadingTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontFamily: 'SF Pro Rounded',
  fontSize: 34,
  fontWeight: FontWeight.w100,
);

final kTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 17,
  fontWeight: FontWeight.w500,
);

final kSubTitleTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 15,
  fontWeight: FontWeight.w500,
);

final kCardTitleTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 13,
  fontWeight: FontWeight.w500,
);

final kBodyTextStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 13,
);

final kCaptionTextStyle = TextStyle(
  color: kSecondaryTextColor,
  fontSize: 10,
);

var kSubtitleStyle = TextStyle(
  fontSize: 14.0,
  color: Colors.black,
);
