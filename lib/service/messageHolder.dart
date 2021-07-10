import 'package:accord/screen/LoginScreen.dart';
import 'package:flutter/material.dart';

class MessageHolder {
  SnackBar popSnackbar(
      String displayMessage, String actionLabel, BuildContext context) {
    if (actionLabel == 'To Login') {
      return SnackBar(
        content: Text(
          displayMessage,
          style: TextStyle(
            color: Color(0xffAAFF00),
            fontSize: 16,
            fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: Color(0xff0F52BA),
        action: SnackBarAction(
          label: actionLabel,
          textColor: Color(0xffB6D0E2),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
        ),
      );
    } else if (actionLabel == 'Try Again') {
      return SnackBar(
        content: Text(
          displayMessage,
          style: TextStyle(
            color: Color(0xffFE7187),
            fontSize: 17,
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
    return null;
  }
}
