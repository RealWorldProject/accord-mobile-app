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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      padding: EdgeInsets.all(7.0),
      // decoration: BoxDecoration(
      //   color: Colors.grey[300],
      //   borderRadius: BorderRadius.circular(15.0),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 219.0,
            width: 175.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),


              // image: DecorationImage(
              //   image: NetworkImage(book.images[0]),
              //   fit: BoxFit.cover,
              // ),
              // borderRadius: BorderRadius.circular(15.0),
            ),
             child: ImageListItem(
                      index: index,
                      width: 175.0,
                      height: 219.0,
                    ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
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

                // book.isAvailableForExchange == false
                //     ? Text(
                //   "Available for Exchange",
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //       fontSize: 10,
                //       fontWeight: FontWeight.w100,
                //       color: Colors.grey[800],
                //       decoration: TextDecoration.lineThrough,
                //       fontStyle: FontStyle.italic),
                // )
                //     : Text(
                //   "Available for Exchange",
                //   overflow: TextOverflow.ellipsis,
                //   style: TextStyle(
                //       fontSize: 11,
                //       fontWeight: FontWeight.w100,
                //       color: Colors.blue,
                //       fontStyle: FontStyle.italic),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 10),
    //   padding: EdgeInsets.all(7.0),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(horizontal: 5),
    //         padding: EdgeInsets.all(7.0),
    //         child: ImageListItem(
    //           index: index,
    //           width: 175.0,
    //           height: 219.0,
    //         ),
    //       ),
    //       SizedBox(
    //         height: 5,
    //       ),
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: 4),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             TextItem(
    //               width: MediaQuery.of(context).size.width / 2 - 40,
    //             ),
    //             TextItem(
    //               width: MediaQuery.of(context).size.width / 2 - 70,
    //             ),
    //             TextItem(
    //               width: MediaQuery.of(context).size.width / 2 - 90,
    //             ),
    //             TextItem(
    //               width: MediaQuery.of(context).size.width / 2 - 60,
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
