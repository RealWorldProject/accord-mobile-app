import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // takes button`s key, button`s text & action the button triggers when clicked upon
  // and returns a working button.
  // buttonKey, distinctively, is used to separate the button in post book form

  // shape of the bottom
  final ButtonShape buttonShape;

  // text for button
  final String buttonText;

  // action that is triggered on button click
  final VoidCallback triggerAction;

  CustomButton({
    this.buttonShape = ButtonShape.ROUNDED_EDGES,
    this.buttonText,
    this.triggerAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: buttonShape == ButtonShape.ROUNDED_EDGES
            ? BorderRadius.circular(5)
            : BorderRadius.circular(40),
        color: Colors.blue,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => triggerAction(),
          child: Center(
            child: CustomText(
              textToShow: buttonText,
              textColor: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonShape {
  OVAL,
  ROUNDED_EDGES,
}
