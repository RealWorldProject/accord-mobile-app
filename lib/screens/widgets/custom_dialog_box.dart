import 'package:accord/screens/widgets/custom_button.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  const CustomDialogBox({
    Key key,
    this.title,
    this.content,
    this.neglectLabel,
    this.neglectAction,
    @required this.performLabel,
    this.performAction,
  }) : super(key: key);

  /// title of the dialog box
  final String title;

  /// message showed in dialog box
  final String content;

  /// text displayed in cancel button of dialog
  final String neglectLabel;

  /// action performed by cancel button of dialog.
  /// default action set to close the dialog box.
  final VoidCallback neglectAction;

  /// text displayed in proceed button of dialog
  final String performLabel;

  /// action performed by proceed button of dialog.
  /// default action set to close the dialog box too.
  final VoidCallback performAction;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title == null
          ? null
          : CustomText(
              textToShow: title,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              textColor: Colors.red.shade400,
              letterSpacing: -1,
            ),
      content: content == null
          ? null
          : Text(
              content,
            ),
      actions: [
        SizedBox(
          height: 30,
          width: 80,
          child: TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            child: neglectLabel == null ? null : Text(neglectLabel),
            onPressed: () {
              neglectAction == null
                  ? Navigator.of(context, rootNavigator: true).pop()
                  : neglectAction();
            },
          ),
        ),
        SizedBox(
          height: 30,
          width: 80,
          child: CustomButton(
            buttonType: ButtonType.LOADING_BUTTON,
            buttonLabel: performLabel,
            triggerAction: performAction ??
                () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ),
      ],
    );
  }
}
