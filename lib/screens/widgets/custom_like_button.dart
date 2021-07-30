import 'package:flutter/material.dart';
class CustomLikeButton extends StatelessWidget {
  const CustomLikeButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      height: 28,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.black54,
          borderRadius: BorderRadius.circular(5)),
      child: IconButton(
        padding: EdgeInsets.only(left: 0),
        onPressed: () {
          // Navigator.pop(context);
        },
        icon: Icon(
          Icons.favorite_outline,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
