import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  const TextItem({
    Key key,
    this.width,
  }) : super(key: key);
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: width,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
