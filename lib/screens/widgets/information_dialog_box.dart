import 'package:flutter/material.dart';

class InformationDialogBox extends StatelessWidget {
  const InformationDialogBox(
      {Key key, this.icon, this.message, this.actionText, this.action})
      : super(key: key);

  // icon to denote the information type i.e, error, information, etc.
  final IconData icon;

  final String message;

  // label for the available action
  final String actionText;

  // action: void function that perform certain task.
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
                message,
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
              child: Icon(
                icon,
                size: 35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
