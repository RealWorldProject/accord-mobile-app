import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  // takes button`s key, button`s text & action the button triggers when clicked upon
  // and returns a working button.
  // buttonKey, distinctively, is used to separate the button in post book form

  /// shape of the bottom
  final ButtonType buttonType;

  /// default set to 50
  final double height;

  /// if null, inherits it's parent's width
  final double width;

  /// text for button
  final String buttonLabel;

  /// button enabled by default
  final bool enable;

  /// action that is triggered on button click
  final VoidCallback triggerAction;

  const CustomButton({
    this.height = 50,
    this.width,
    this.buttonType = ButtonType.ROUNDED_EDGE,
    this.buttonLabel,
    this.enable = true,
    @required this.triggerAction,
  });

  @override
  Widget build(BuildContext context) {
    if (buttonType == ButtonType.OUTLINED) {
      return SizedBox(
        height: height,
        width: width,
        child: OutlinedButton(
          onPressed: () => triggerAction(),
          child: Text(
            buttonLabel,
            style: TextStyle(
              color: enable ? AccordColors.primary_blue_color : Colors.black26,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          style: OutlinedButton.styleFrom(
              splashFactory: enable ? null : NoSplash.splashFactory,
              primary: AccordColors.primary_blue_color,
              side: BorderSide(
                color:
                    enable ? AccordColors.primary_blue_color : Colors.black26,
                width: 1.5,
              )),
        ),
      );
    }

    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: buttonType == ButtonType.ROUNDED_EDGE
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
              textToShow: buttonLabel,
              textColor: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

enum ButtonType {
  OVAL,
  ROUNDED_EDGE,
  OUTLINED,
}
