import 'package:accord/constant/accord_colors.dart';
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  const CustomOutlineButton({Key key, this.enable}) : super(key: key);

  // used for separating the widget's visuals
  final bool enable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      width: 145,
      child: OutlinedButton(
        onPressed: () {},
        child: Text(
          "Request Exchange",
          style: TextStyle(
            color: enable ? AccordColors.primary_blue_color : Colors.black26,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        style: OutlinedButton.styleFrom(
            splashFactory: enable ? null : NoSplash.splashFactory,
            primary: AccordColors.primary_blue_color,
            side: BorderSide(
              color: enable ? AccordColors.primary_blue_color : Colors.black26,
              width: 1.5,
            )),
      ),
    );
  }
}
