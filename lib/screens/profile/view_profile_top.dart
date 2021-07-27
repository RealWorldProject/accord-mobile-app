import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:line_icons/line_icons.dart';

class ViewProfileTop extends StatelessWidget {
  const ViewProfileTop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: MediaQuery.of(context).size.height / 3.8,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff1b98e0),
                // image: DecorationImage(
                //   image: AssetImage("assets/images/profileBG.png"),
                //   fit: BoxFit.cover,
                //
                //   // image: Image.asset("assets/images/profileBG.png",height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
                // ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height / 5.8,
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4, color: Colors.black38, spreadRadius: 2)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 56.0,
                      backgroundImage: AssetImage("assets/images/user2.png"),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
              Text(
                "John Doe",
                style: TextStyle(
                    color: Color(0xff13293d),
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "johndoe@gmail.com",
                style: TextStyle(color: Colors.blueGrey, fontSize: 14),
              ),
            ],
          ),
        ),
        Positioned(
          top: 85,
          left: 15,
          child: Container(
            padding: EdgeInsets.zero,
            height: 26,
            width: 26,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.2),
                borderRadius: BorderRadius.circular(5)),
            child: IconButton(
              padding: EdgeInsets.only(left: 5),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
