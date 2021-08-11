import 'package:accord/constant/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  CustomButton({this.text});

  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Constant.primary_blue_color),
        padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 20)),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
