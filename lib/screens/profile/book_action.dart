import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class BookAction extends StatelessWidget {
  // show bottom sheet modal


  final VoidCallback editOption;
  final VoidCallback deleteOption;

  const BookAction({Key key, this.editOption, this.deleteOption})
      : super(key: key);

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
                  Icons.edit_rounded,size: 22, color: Colors.blue,
                ),
                title: CustomText(
                  textToShow: "Edit Book",
                  textColor: Colors.blue,
                ),
                onTap: () {
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
                  Icons.delete_forever_rounded,size: 24, color: Colors.red,
                ),
                title: CustomText(
                  textToShow: "Delete",
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
