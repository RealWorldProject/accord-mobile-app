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
      textColor: messageType == MessageType.ErrorMessage
          ? Color(0xffFE7187)
          : Color(0xffAAFF00),
      fontSize: 16,
      fontStyle: FontStyle.italic,
      noOfLines: 3,
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

enum MessageType {
  ErrorMessage,
  InformationMessage,
}
