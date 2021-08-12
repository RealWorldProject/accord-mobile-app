import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:flutter/material.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key key}) : super(key: key);
  static const double imageHeight = 100.0;
  static const double imageWidth = 90.0;

  _orderListView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      height: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcR7IcZHkFtiEEEF20_gIMTSFWLqJyD70W4TQ2r1Gf71IKVn1bRb',
                        height: imageHeight,
                        width: imageWidth,
                        fit: BoxFit.cover,
                      ),
                      // child: Image.network(
                      //   cartItem.images,
                      //   height: imageHeight,
                      //   width: imageWidth,
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Godard the image book",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900]),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "William Di Vanci",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              color: Colors.grey[600],
                              fontStyle: FontStyle.italic),
                        ),
                        RatingStars(
                          4.5,
                          20.0,
                        ),
                        Text(
                          ("x1"),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff247BA0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Rs. 250",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff247BA0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              child: _orderListView(),
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed request'),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: (){

                      },
                    ),
                  ),
                );
              },
              background: Container(color:Colors.red),
            );
          }),
    );
  }
}
