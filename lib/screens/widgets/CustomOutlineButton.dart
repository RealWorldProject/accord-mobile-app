import 'package:accord/constant/constant.dart';
import 'package:flutter/material.dart';
class CustomOutlineButton extends StatefulWidget {
  const CustomOutlineButton({Key key}) : super(key: key);

  @override
  _CustomOutlineButtonState createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 145,
      child: OutlinedButton(

        child: Text("Request Exchange",style: TextStyle(color: Constant.primary_blue_color,fontWeight: FontWeight.w600,fontSize: 12),),
        style: OutlinedButton.styleFrom(
          primary: Constant.primary_blue_color,
          side: BorderSide(color: Constant.primary_blue_color,width: 1.5)
        ),
      ),
    );
  }
}
