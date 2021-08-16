import 'package:accord/screens/home/book_view/rating_stars.dart';
import 'package:flutter/material.dart';

class OrderListView extends StatelessWidget {
  const OrderListView({Key key}) : super(key: key);
  static const double imageHeight = 70.0;
  static const double imageWidth = 65.0;

  _orderListView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(0.0)),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order 78541287412",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey[800]),
          ),
          Text(
            "Placed On 08 Mar 2021 11:35",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.grey[400]),
          ),
          Divider(
            height: 0,
            thickness: 0.5,
            indent: 0,
            endIndent: 0,
            color: Colors.grey[200],
          ),
          Row(
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
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900]),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "William Di Vanci",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                  fontStyle: FontStyle.italic),
                            ),
                            Text(
                              "Rs 250",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                            Text(
                              ("x1"),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Color(0xff247BA0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3,),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "1 Item,",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(width: 3,),
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(width: 3,),
              Text(
                "Rs. 250",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff247BA0),

                ),
              ),

            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return _orderListView();
          }),
    );
  }
}
