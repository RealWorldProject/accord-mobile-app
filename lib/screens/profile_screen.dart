import 'package:accord/screens/post_book.dart';
import 'package:accord/screens/profile/view_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff1f1f1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: ClipPath(
                  clipper: ArcClipper(),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/profileBG.png"),
                        fit: BoxFit.fill,

                        // image: Image.asset("assets/images/profileBG.png",height: MediaQuery.of(context).size.height,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 74.0,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 70.0,
                          backgroundImage:
                              AssetImage("assets/images/user2.jpg"),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Text(
                      "John Doe",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "johndoe@gmail.com",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 9, vertical: 10),
                      width: MediaQuery.of(context).size.width / 1.25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewProfilePage()));
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.person_rounded,
                                  size: 32,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "View Profile",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(
                                  Icons.favorite,
                                  size: 32,
                                  color: Colors.redAccent[700],
                                ),
                                title: Text(
                                  "Favourites",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(
                                  Icons.menu_book_rounded,
                                  size: 32,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "My Books",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(
                                  Icons.edit,
                                  size: 32,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "Change Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                leading: Icon(
                                  Icons.logout,
                                  size: 32,
                                  color: Color(0xff0a78b2),
                                ),
                                title: Text(
                                  "Logout",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff1b98e0)),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            thickness: 1,
                            indent: 13,
                            endIndent: 13,
                            color: Color(0xffafa9a9),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 15,
                right: 15,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  iconSize: 26,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// return SingleChildScrollView(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: [
// Stack(
// overflow: Overflow.visible,
// children: <Widget>[
//
// ClipRRect(
// // borderRadius: BorderRadius.circular(8.0),
// child: Image.asset(
// 'assets/images/wat.jpg',
// height: 250,
// width: double.infinity,
// fit: BoxFit.cover,
// ),
// ),
// // Positioned(
// //   top: 1,
// //   left: 1,
// //   child: InkWell(
// //
// //     child: Container(
// //       height: 45,
// //       width: 45,
// //       child: Icon(
// //         Icons.arrow_back_ios,
// //         color: Colors.blue,
// //       ),
// //     ),
// //   ),
// // ),
// Positioned(
// bottom: 1,
// right: 1,
// child: Container(
// height: 45,
// width: 45,
// child: Icon(
// Icons.add_a_photo,
// color: Colors.white,
// ),
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.all(
// Radius.circular(25),
// ),
// ),
// ),
// ),
// ],
// ),
// Flexible(
// child: Container(
// child: TextFormField(),
// ))
// ],
// ),
// );
