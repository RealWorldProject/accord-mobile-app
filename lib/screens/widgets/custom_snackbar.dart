import 'package:accord/constant/accord_colors.dart';
import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

Widget customSnackbar({
  @required String content,
  @required BuildContext context,
  MessageType messageType = MessageType.ErrorMessage,
  String actionLabel = "",
}) {
  return SnackBar(
    content: CustomText(
      textToShow: content,
      textColor: Colors.white,
      fontSize: 16,
      fontStyle: FontStyle.italic,
      noOfLines: 3,
    ),
    backgroundColor: AccordColors.semi_dark_blue_color,
    action: SnackBarAction(
      label: actionLabel,
      textColor: Colors.grey[400],
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
}

enum MessageType {
  ErrorMessage,
  InformationMessage,
}
