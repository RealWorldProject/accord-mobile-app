import 'package:accord/screens/shimmer/image_list_item.dart';
import 'package:accord/screens/shimmer/text_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: ImageListItem(
              index: index,
              width: 175.0,
              height: 219.0,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
            ),
          )
        ],
      ),
    );
  }
}
