import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  // takes text that is to be displayed and returns Text object.
  // holderKey represents any widget that `textToShow` resides upon.
  // and holderKey should start with prefix representing their widget
  // like `btn for button`, `lbl for label`, `etf for edit text field`, etc.
  // these prefix must be only 3 characters.

  // `textToShow` is the main parameter while the remaining depends on developer's need
  final String holderKey;
  final String textToShow;
  final Color textColor;
  final FontWeight fontWeight;

  CustomText({
    this.holderKey,
    this.textToShow,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    // checking if holderKey is null and fetching its prefix.
    final keyPrefix = (holderKey == null) ? "" : holderKey.substring(0, 3);
    return Text(
      textToShow,
      style: TextStyle(
        // differentiating font size in reference to the prefix of holderKey.
        fontSize: (() {
          if (keyPrefix == "rdo" || keyPrefix == "lnk" || keyPrefix == "ask") {
            return 16.toDouble();
          } else if (keyPrefix == "ttl" || keyPrefix == "grt") {
            return 30.toDouble();
          } else {
            return 18.toDouble();
          }
        }()),
        // differentiating font weight in reference to the prefix of holderKey.
        fontWeight: (() {
          if (keyPrefix == "lnk" ||
              keyPrefix == "ask" ||
              keyPrefix == "tag" ||
              keyPrefix == "gid") {
            return null;
          } else {
            return FontWeight.w600;
          }
        }()),
        color: textColor,
      ),
    );
  }
}
