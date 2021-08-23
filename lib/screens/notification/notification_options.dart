import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class NotificationOptions extends StatelessWidget {
  const NotificationOptions({
    Key key,
    this.markasreadOption,
    this.removeOption,
    this.value,
  }) : super(key: key);

  final VoidCallback markasreadOption;
  final VoidCallback removeOption;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      Container(
        color: Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              ListTile(
                leading: Icon(
                  Icons.library_add_check_rounded,
                  size: 22,
                  color: Colors.blue,
                ),
                title: value == false
                    ? CustomText(
                        textToShow: "Mark as read",
                        textColor: Colors.blue,
                      )
                    : CustomText(
                        textToShow: "Mark as unread",
                        textColor: Colors.blue,
                      ),
                onTap: () {
                  markasreadOption();

                  Navigator.of(context).pop();
                },
              ),
              Divider(
                height: 1,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_forever_rounded,
                  size: 24,
                  color: Colors.red,
                ),
                title: CustomText(
                  textToShow: "Remove this notification",
                  textColor: Colors.red,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
