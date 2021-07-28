import 'package:accord/screens/widgets/custom_label.dart';
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    Key key,
    this.option1,
    this.option2,
    this.option3,
    this.action1,
    this.action2,
    this.action3,
    this.iconOpt1,
    this.iconOpt2,
    this.iconOpt3,
  }) : super(key: key);

  final String option1;
  final String option2;
  final String option3;
  final VoidCallback action1;
  final VoidCallback action2;
  final VoidCallback action3; //corresponding in-case option action
  final IconData iconOpt1;
  final IconData iconOpt2;
  final IconData iconOpt3; //corresponding in-case icon

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
                  iconOpt1,
                  size: 22,
                  color: Colors.blue,
                ),
                title: CustomText(
                  textToShow: option1,
                  textColor: Colors.blue,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  action1();
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
                  iconOpt2,
                  size: 24,
                  color: Colors.red,
                ),
                title: CustomText(
                  textToShow: option2,
                  textColor: Colors.red,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  action2();
                },
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
