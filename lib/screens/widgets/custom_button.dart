import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // takes button`s key, button`s text & action the button triggers when clicked upon
  // and returns a working button.
  // buttonKey, distinctively, is used to separate the button in post book form
  final String buttonKey;
  final String buttonText;
  final VoidCallback triggerAction;

  CustomButton({
    this.buttonKey,
    this.buttonText,
    this.triggerAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: (() {
          if (buttonKey == "btnPostBook") {
            return BorderRadius.circular(10);
          } else {
            return BorderRadius.circular(40);
          }
        }()),
        color: Colors.blue,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            triggerAction();
          },
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
