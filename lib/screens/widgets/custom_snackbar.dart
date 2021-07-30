import 'package:flutter/material.dart';

class MessageHolder {
  SnackBar popSnackbar(
      String displayMessage, String actionLabel, BuildContext context) {
    return SnackBar(
      content: Text(
        displayMessage,
        style: TextStyle(
          color: (actionLabel == "Okay" || actionLabel == "")
              ? Color(0xffAAFF00)
              : Color(0xffFE7187),
          fontSize: 16,
          fontStyle: FontStyle.italic,
        ),
      ),
      backgroundColor: Color(0xff0F52BA),
      action: SnackBarAction(
        label: actionLabel,
        textColor: Color(0xffB6D0E2),
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
  }
}
