import 'package:accord/screens/profile/view_page_body.dart';
import 'package:accord/screens/profile/view_profile_top.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:line_icons/line_icons.dart';

class ViewProfilePage extends StatefulWidget {
  const ViewProfilePage({Key key}) : super(key: key);

  @override
  _ViewProfilePageState createState() => _ViewProfilePageState();
}

class _ViewProfilePageState extends State<ViewProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            ViewProfileTop(),
            Container(
              padding: EdgeInsets.all(8),

              width: double.infinity,
              // decoration: BoxDecoration(
              //     color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        color: Color(0xff13293d), borderRadius: BorderRadius.circular(5)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){print("Edit Profile");},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(LineIcons.userEdit,size: 22,color: Colors.white,),
                              // Icon(Icons.user,size: 22,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text("Edit Details",style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: (){print("Add book");},
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 5),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline_rounded,size: 22,color: Colors.white,),
                              SizedBox(width: 10,),
                              Text("Add Book",style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w400),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ViewPageBody(),
            ViewPageBody(),


          ],
        ),
      ),
    );
  }
}
