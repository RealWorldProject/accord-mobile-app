import 'package:accord/screens/shimmer/image_list_item.dart';
import 'package:accord/screens/shimmer/text_item.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: 20,
            left: 10,
          ),
          padding: EdgeInsets.all(7.0),
          child: ImageListItem(
            index: index,
            sizeRatio: 4 / 5,
          ),
        ),
        TextItem(
          width: MediaQuery.of(context).size.width / 2 - 40,
        ),
        TextItem(
          width: MediaQuery.of(context).size.width / 2 - 70,
        ),
        TextItem(
          width: MediaQuery.of(context).size.width / 2 - 90,
        ),
        TextItem(
          width: MediaQuery.of(context).size.width / 2 - 60,
        ),
      ],
    );
  }
}
