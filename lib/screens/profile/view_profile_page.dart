import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({Key key}) : super(key: key);

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                child: ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3.5,
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

            ],
          ),
        ],
      ),
    );
  }
}
