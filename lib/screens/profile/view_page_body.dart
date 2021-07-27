import 'package:accord/screens/book_view/rating_stars.dart';
import 'package:accord/screens/profile/book_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPageBody extends StatefulWidget {
  const ViewPageBody({Key key}) : super(key: key);

  @override
  _ViewPageBodyState createState() => _ViewPageBodyState();
}

class _ViewPageBodyState extends State<ViewPageBody> {
  Future<void> _editBookDetail() async {

  }
  Future<void> _deleteBook() async {

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 8),
            leading: CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage("assets/images/user2.png"),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              "John Doe",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff13293d),
              ),
            ),
            trailing: GestureDetector(
              onTap: () {
                showModalBottomSheet(context: context, builder: (context) =>BookAction(
                  editOption:_editBookDetail,
                  deleteOption:_deleteBook,
                ));
              },

              child: Icon(Icons.more_vert_rounded),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/bg1.jpg",
                  fit: BoxFit.contain,
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black26,
                ),
              ),
              Positioned(
                bottom: -20,
                right: 20,
                child: Container(
                  padding: EdgeInsets.zero,
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding:
                        EdgeInsets.only(top: 4, bottom: 0, left: 0, right: 0),
                    alignment: Alignment.center,
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    iconSize: 25,
                  ),
                ),
              ),
              Positioned(
                  top: 6,
                  left: 6,
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/tag-shape.png"),
                    radius: 22,
                    child: Center(
                      child: RotationTransition(
                        turns: new AlwaysStoppedAnimation(320 / 360),
                        child: Text(
                          "NEW",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    // backgroundColor: Color(0xff19b128),
                    backgroundColor: Colors.transparent,
                  ))
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The Gravity of US",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[900]),
                ),
                Text(
                  "Phil Stamper",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey[700],
                      fontStyle: FontStyle.italic),
                ),
                RatingStars(5),
                Text(
                  "Available for Exchange",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                      color: Colors.blue,
                      fontStyle: FontStyle.italic),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Rs. 500",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff247BA0),
                        ),
                      ),
                      Container(
                        height: 30,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Color(0xff13293D),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.shopping_cart),
                          iconSize: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
