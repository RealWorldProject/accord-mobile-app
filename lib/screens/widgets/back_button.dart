import 'package:flutter/material.dart';

class CutomeBackButton extends StatelessWidget {
  const CutomeBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 28,
      width: 28,
      decoration: BoxDecoration(
        color: Colors.black54,
          borderRadius: BorderRadius.circular(5)),
      child: IconButton(
        padding: EdgeInsets.only(left: 8),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}
