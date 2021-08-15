import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  // takes text that is to be displayed and returns Text object.
  // holderKey represents any widget that `textToShow` resides upon.
  // and holderKey should start with prefix representing their widget
  // like `btn for button`, `lbl for label`, `etf for edit text field`, etc.
  // these prefix must be only 3 characters.

  // `textToShow` is the main parameter while the remaining depends on developer's need
  final double fontSize;
  final String textToShow;
  final Color textColor;
  final FontWeight fontWeight;
  final int noOfLines;
  final TextOverflow overflow;
  final double letterSpacing;
  final FontStyle fontStyle;
  final TextDecoration textDecoration;

  CustomText({
    this.fontSize = 18,
    @required this.textToShow,
    this.textColor,
    this.fontWeight = FontWeight.w500,
    this.noOfLines = 1,
    this.overflow,
    this.letterSpacing = 0,
    this.fontStyle = FontStyle.normal,
    this.textDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textToShow,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: textColor,
          letterSpacing: letterSpacing,
          fontStyle: fontStyle,
          decoration: textDecoration),
      maxLines: noOfLines,
      overflow: overflow == null ? null : overflow,
    );
  }
}
