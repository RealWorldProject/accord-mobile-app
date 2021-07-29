import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    Key key,
    this.title,
    this.confirmMessage,
    this.dontText,
    this.doText,
    this.dontAction,
    this.doAction,
  }) : super(key: key);

  final String title;
  final String confirmMessage;
  final String dontText;
  final String doText;
  final VoidCallback dontAction;
  final VoidCallback doAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.red.shade400,
          letterSpacing: -1,
        ),
      ),
      content: Text(
        confirmMessage,
      ),
      actions: [
        TextButton(
          child: Text(dontText),
          onPressed: () {
            dontAction();
          },
        ),
        TextButton(
          child: Text(doText),
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.red),
          onPressed: () {
            doAction();
          },
        ),
      ],
    );
  }
}
