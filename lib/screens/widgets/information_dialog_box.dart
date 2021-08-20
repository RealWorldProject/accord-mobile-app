import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class InformationDialogBox extends StatelessWidget {
  const InformationDialogBox({
    Key key,
    @required this.contentType,
    @required this.content,
    @required this.actionText,
    this.action,
  }) : super(key: key);

  /// Type of information to be displayed.
  final ContentType contentType;

  /// Message to display in dialog.
  final String content;

  /// Label for the available action
  final String actionText;

  /// (Optional) Function that perform certain task.
  /// Default set to close the dialog box.
  final VoidCallback action;

  static const double padding = 10;
  static const double infoIconRadius = 30;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: padding,
              top: infoIconRadius + padding,
              right: padding,
              bottom: padding),
          margin: EdgeInsets.only(top: infoIconRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(padding),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[900],
                offset: Offset(0, 10),
                blurRadius: 10,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 2,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      action != null
                          ? action()
                          : Navigator.of(context, rootNavigator: true).pop();
                    },
                    child: Text(
                      actionText,
                      style: TextStyle(fontSize: 16),
                    )),
              ),
            ],
          ),
        ),
        Positioned(
          left: padding,
          right: padding,
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: infoIconRadius,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(infoIconRadius)),
              child: (() {
                if (contentType == ContentType.INFORMATION) {
                  return Icon(
                    LineIcons.info,
                    color: Colors.blue,
                    size: 35,
                  );
                } else if (contentType == ContentType.ERROR) {
                  return Icon(
                    Icons.warning_amber,
                    color: Colors.red,
                    size: 35,
                  );
                } else {
                  return Icon(
                    LineIcons.doubleCheck,
                    color: Colors.green,
                    size: 35,
                  );
                }
              }()),
            ),
          ),
        ),
      ],
    );
  }
}

enum ContentType {
  INFORMATION,
  ERROR,
  DONE,
}
