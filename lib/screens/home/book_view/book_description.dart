import 'package:accord/constant/constant.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class BookDescription extends StatelessWidget {
  const BookDescription({Key key, this.description}) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ExpandablePanel(
        header: Text(
          "Description",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Constant.semi_dark_blue_color),
        ),
        collapsed: Text(
          description,
          softWrap: true,
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.grey[700]),
        ),
        expanded: Text(
          description,
          softWrap: true,
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 12,
              color: Colors.grey[700]),
        ),
      ),
    );
  }
}
