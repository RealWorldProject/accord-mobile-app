import 'package:flutter/material.dart';

class IncomingRequest extends StatefulWidget {
  const IncomingRequest({Key key}) : super(key: key);

  @override
  _IncomingRequestState createState() => _IncomingRequestState();
}

class _IncomingRequestState extends State<IncomingRequest> {
  _incomingRequestBuilder() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/user2.png",
                  ),
                  radius: 30,
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
                          text: " sent you request to exchange book ",
                        ),
                        TextSpan(
                          text: "Harry Potter",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                        TextSpan(
                          text: " for ",
                        ),
                        TextSpan(
                          text: "50 Shades of Grey.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff13293d),
                          ),
                        ),
                      ],
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff606060),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.8,
                  ),
                  Text(
                    "12 hour ago",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1b98e0),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 120,

                        // width: MediaQuery.of(context).size.width/2.2,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Accept",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                            color: Color(0xff13293d),
                            borderRadius: BorderRadius.circular(5)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              print("decline");
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Decline",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.grey[600],
                  ),
                ),
              ),
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
              child: _incomingRequestBuilder(),
              onDismissed: (direction) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed Item'),
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
