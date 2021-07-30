import 'package:accord/constant/constant.dart';
import 'package:accord/screens/widgets/CustomOutlineButton.dart';
import 'package:flutter/material.dart';
class BookUploadedUserInfo extends StatefulWidget {
  const BookUploadedUserInfo({Key key}) : super(key: key);

  @override
  _BookUploadedUserInfoState createState() => _BookUploadedUserInfoState();
}

class _BookUploadedUserInfoState extends State<BookUploadedUserInfo> {
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 10 ),
    //   padding: EdgeInsets.symmetric(vertical: 6),
    //   color: Colors.white,
    //   child: ListTile(
    //     contentPadding: EdgeInsets.symmetric(horizontal: 5),
    //     leading: CircleAvatar(
    //       radius: 30.0,
    //       backgroundImage: AssetImage("assets/images/user2.png"),
    //       backgroundColor: Colors.transparent,
    //     ),
    //     title: Text(
    //
    //       "John Doe",
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Color(0xff13293d),
    //       ),
    //       textAlign: TextAlign.start,
    //     ),
    //     trailing: CustomOutlineButton()
    //   ),
    // );
    return Container(
      margin: EdgeInsets.only(top: 10 ),
        padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              CircleAvatar(
                radius: 28.0,
                backgroundImage: AssetImage("assets/images/user2.png"),
                backgroundColor: Colors.transparent,
              ),
              Text(
                "John Doe ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constant.full_dark_blue_color,
                        fontSize: 16
                      ),
                overflow: TextOverflow.visible,
              ),
      ],

          ),
              CustomOutlineButton()
        ],
      ),
    );
  }
}
