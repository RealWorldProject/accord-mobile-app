import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class NotificationTile extends StatefulWidget {
  const NotificationTile({Key key}) : super(key: key);

  @override
  _NotificationTileState createState() => _NotificationTileState();
}

class _NotificationTileState extends State<NotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/user2.jpg",
                  ),
                  radius: 30 ,
                )
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              margin: EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Keanu Reeves",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text:
                              " accepted your request. You can now see the contact information of ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // TextSpan(
                        //   text:
                        //   " declined your request. You can not see the contact information of ",
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        TextSpan(
                          text: "John Doe.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xff606060),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.8,),
                  Text(
                    "12 hour ago",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b98e0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}